import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database_miniTB.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class MiniTBStandings extends StatelessWidget {
  const MiniTBStandings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return StreamBuilder(
      stream: DatabaseServiceMiniTB().preds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MiniTBPred> preds = snapshot.data as List<MiniTBPred>;
          MiniTBPred reference = MiniTBPred("", {}, {}, "");
          for (var i = 0; i < preds.length; i++) {
            if (preds[i].name == "Admin") {
              reference = preds[i];
            }
          }
          String todayString = reference.date;
          DateTime todayDate = DateTime.parse(todayString);
          DateTime yesterdayDate = todayDate.subtract(new Duration(days: 1));
          String sponsor = sponsors[DateTime.now().weekday - 1];
          return FutureBuilder(
              future: DatabaseServiceMiniTB()
                  .dailyStandings(formatter.format(yesterdayDate)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  MiniTBPred yesterday = snapshot.data as MiniTBPred;
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.blue[400],
                      title: const Text('Mini TB - Classifica'),
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.home, color: Colors.white),
                          onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    ),
                    backgroundColor: Colors.blue[200],
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                "MiniTB Standings of the Day",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                              child: Text(
                                "Presented by $sponsor",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: SelectableText(
                                miniTBStandings(preds, yesterday),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(9, 10, 9, 0),
                              child: Card(
                                child: ListTile(
                                  leading: const Icon(MdiIcons.whatsapp),
                                  trailing: const Icon(Icons.send),
                                  title: Text("Manda classifica alla CB",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 18)),
                                  onTap: () async => await launch(
                                    WhatsAppUnilink(
                                      text:
                                          "*MiniTB Standings of the Day*\n_Presented by ${sponsor}_\n\n" +
                                              miniTBStandings(preds, yesterday),
                                    ).toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Loading();
                }
              });
        } else {
          return const Loading();
        }
      },
    );
  }
}
