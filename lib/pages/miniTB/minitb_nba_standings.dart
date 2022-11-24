import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database_miniTB.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:intl/intl.dart';

class MiniTBNBAStandings extends StatelessWidget {
  const MiniTBNBAStandings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return StreamBuilder(
        stream: DatabaseServiceMiniTB().preds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MiniTBPred> preds = snapshot.data as List<MiniTBPred>;
            MiniTBPred reference = MiniTBPred("", {}, {}, "", {});
            for (var i = 0; i < preds.length; i++) {
              if (preds[i].name == "Admin") {
                reference = preds[i];
              }
            }
            String todayString = reference.date;
            DateTime todayDate = DateTime.parse(todayString);
            DateTime yesterdayDate = todayDate.subtract(new Duration(days: 1));
            return FutureBuilder(
                future: DatabaseServiceMiniTB()
                    .dailyStandings(formatter.format(todayDate)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MiniTBPred today = snapshot.data as MiniTBPred;
                    return FutureBuilder(
                      future: DatabaseServiceMiniTB()
                          .dailyStandings(formatter.format(yesterdayDate)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          MiniTBPred yesterday = snapshot.data as MiniTBPred;
                          return Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.blue[400],
                              title: const Text('NBA Standings'),
                              centerTitle: true,
                              actions: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.home,
                                      color: Colors.white),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Text(
                                        "NBA Standings (${formatter.format(todayDate)})",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text('EAST'),
                                            const SizedBox(height: 15),
                                            StandingsList(
                                              key: const Key("StandingsList"),
                                              todayList: List<String>.from(
                                                  buildCurrentList(today.east)),
                                              todayWins: today.wins,
                                              yesterday: yesterday.east,
                                            ),
                                          ],
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text('WEST'),
                                              const SizedBox(height: 10),
                                              StandingsList(
                                                key: const Key("StandingsList"),
                                                todayList: List<String>.from(
                                                    buildCurrentList(
                                                        today.west)),
                                                todayWins: today.wins,
                                                yesterday: yesterday.west,
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Loading();
                        }
                      },
                    );
                  } else {
                    return const Loading();
                  }
                });
          } else {
            return const Loading();
          }
        });
  }
}

class StandingsList extends StatefulWidget {
  final List<String> todayList;
  final Map todayWins;
  final Map yesterday;

  const StandingsList(
      {required Key key, required this.todayList, required this.todayWins, required this.yesterday})
      : super(key: key);

  @override
  _StandingsListState createState() => _StandingsListState();
}

class _StandingsListState extends State<StandingsList> {
  @override
  Widget build(BuildContext context) {
    var todayList = widget.todayList;
    var todayWins = widget.todayWins;
    var yestarday = widget.yesterday;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 215,
            maxWidth: 0.45 * MediaQuery.of(context).size.width,
          ),
          child: ListView(
            children: List.generate(todayList.length, (index) {
              num diff = index - yestarday[todayList[index]] + 1;
              String wins = todayWins[todayList[index]] ?? "";
              MaterialColor color = Colors.grey;
              String display = '=';
              if (diff > 0) {
                color = Colors.red;
                display = '\u2193${diff}';
              }
              if (diff < 0) {
                color = Colors.green;
                display = '\u2191${-diff}';
              }
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                      children: [
                        TextSpan(text: '${index + 1}: ${todayList[index]}  ('),
                        TextSpan(
                            text: '${display}', style: TextStyle(color: color)),
                        TextSpan(text: ')'),
                        TextSpan(text: ' (${wins})')
                      ],
                    ))
                  ],
                ),
              ));
            }),
          ),
        ),
      ],
    );
  }
}
