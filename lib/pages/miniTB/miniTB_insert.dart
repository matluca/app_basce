import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database_miniTB.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';

class MiniTBInsertPrediction extends StatefulWidget {
  const MiniTBInsertPrediction({Key? key}) : super(key: key);

  @override
  _MiniTBInsertPredictionState createState() => _MiniTBInsertPredictionState();
}

class _MiniTBInsertPredictionState extends State<MiniTBInsertPrediction> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return InsertPredictionPage(
        key: const Key("InsertPredictionPage"), index: index);
  }
}

class InsertPredictionPage extends StatefulWidget {
  final int index;

  const InsertPredictionPage({required Key key, required this.index})
      : super(key: key);

  @override
  _InsertPredictionPageState createState() => _InsertPredictionPageState();
}

class _InsertPredictionPageState extends State<InsertPredictionPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServiceMiniTB().preds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MiniTBPred> preds = snapshot.data as List<MiniTBPred>;
          MiniTBPred pred = MiniTBPred("", {}, {}, "", {}, "");
          for (var i = 0; i < preds.length; i++) {
            if (preds[i].name == miniTBParticipants[widget.index].name) {
              pred = preds[i];
            }
          }
          var eastPred = List<String>.from(buildCurrentList(pred.east));
          var westPred = List<String>.from(buildCurrentList(pred.west));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: Text(
                  '${miniTBParticipants[widget.index].name}, riordina le liste'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
            backgroundColor: Colors.blue[200],
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                  children: [
                    const Text(
                      'Tieni premuto per poter riordinare',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('EAST'),
                            const SizedBox(height: 10),
                            StandingsList(
                                key: const Key("StandingsList"),
                                teams: eastPred),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('WEST'),
                              const SizedBox(height: 10),
                              StandingsList(
                                  key: const Key("StandingsList"),
                                  teams: westPred),
                            ]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text(
                          'Update and exit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          DatabaseServiceMiniTB().updatePredictionsFromOrderedList(
                              miniTBParticipants[widget.index].name,
                              eastPred,
                              westPred);
                          Navigator.popUntil(
                              context, ModalRoute.withName('/mini_tb'));
                        },
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
      },
    );
  }
}

class StandingsList extends StatefulWidget {
  final List<String> teams;

  const StandingsList({required Key key, required this.teams})
      : super(key: key);

  @override
  _StandingsListState createState() => _StandingsListState();
}

class _StandingsListState extends State<StandingsList> {
  @override
  Widget build(BuildContext context) {
    var teams = widget.teams;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 215,
            maxWidth: 0.45 * MediaQuery.of(context).size.width,
          ),
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final String item = teams.removeAt(oldIndex);
                teams.insert(newIndex, item);
              });
            },
            children: List.generate(teams.length, (index) {
              return ListTile(
                dense: true,
                key: Key('$index'),
                title: Container(
                    height: 30,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child:
                        Center(child: Text('${index + 1}: ${teams[index]}'))),
              );
            }),
          ),
        ),
      ],
    );
  }
}
