import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniTBStandings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().preds,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          List<MiniTBPred> preds = snapshot.data;
          MiniTBPred reference;
          for (var i=0; i<preds.length; i++) {
            if (preds[i].name == "Admin") {
              reference = preds[i];
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: Text('Mini TB - Classifica'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
                ),
              ],
            ),
            backgroundColor: Colors.blue[200],
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    "Presented by Chick-fil-a",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SelectableText(
                    miniTBStandings(preds),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 10, 9, 0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(MdiIcons.whatsapp),
                      trailing: Icon(Icons.send),
                      title: Text(
                          "Manda classifica alla CB",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18)
                      ),
                      onTap: () async => await launch(
                        WhatsAppUnilink(
                          text: "*MiniTB Standings of the Day*\n_Presented by Chick-fil-a_\n\n" + miniTBStandings(preds),
                        ).toString(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class Predictions extends StatefulWidget {
  final MiniTBPred prediction;
  final MiniTBPred reference;
  final bool showMalus;

  Predictions({ Key key, this.prediction, this.reference, this.showMalus }) : super(key: key);

  @override
  _PredictionsState createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  @override
  Widget build(BuildContext context) {

    var eastStandings = buildStandings(widget.prediction.east).toString();
    eastStandings = eastStandings.substring(1, eastStandings.length-1);
    var westStandings = buildStandings(widget.prediction.west).toString();
    westStandings = westStandings.substring(1, westStandings.length-1);
    var m = malus(widget.prediction, widget.reference);
    var showMalus = widget.showMalus;

    return Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*0.8,
        child: Card(
          margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Column(
            children: [
              ListTile(
                title: Text('East'),
                subtitle: Text('$eastStandings'),
              ),
              ListTile(
                title: Text('West'),
                subtitle: Text('$westStandings'),
              ),
              showMalus ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Malus East: ${m[0]}, Malus West: ${m[1]}, Malus Tot: ${m[0]+m[1]}',
                  style: TextStyle(color: Colors.red[600]),
                ),
              ) : Container(),
            ],
          ),
        )
    );
  }
}



