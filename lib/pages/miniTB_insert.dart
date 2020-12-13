import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/services/database.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';

class MiniTBInsertPrediction extends StatefulWidget {
  @override
  _MiniTBInsertPredictionState createState() => _MiniTBInsertPredictionState();
}

class _MiniTBInsertPredictionState extends State<MiniTBInsertPrediction> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments;
    return InsertPredictionPage(index: index);
  }
}

class InsertPredictionPage extends StatefulWidget {
  final int index;

  const InsertPredictionPage({Key key, this.index}) : super(key: key);

  @override
  _InsertPredictionPageState createState() => _InsertPredictionPageState();
}

class _InsertPredictionPageState extends State<InsertPredictionPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().preds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MiniTBPred> preds = snapshot.data;
          MiniTBPred pred;
          for (var i = 0; i < preds.length; i++) {
            if (preds[i].name == profiles[widget.index].name) {
              pred = preds[i];
            }
          }
          var eastPred = new List<String>.from(buildCurrentList(pred.east));
          var westPred = new List<String>.from(buildCurrentList(pred.west));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: Text('${profiles[widget.index].name}, riordina le liste'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
            backgroundColor: Colors.blue[200],
            body: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: Column(
                    children: [
                      Text(
                        'Tieni premuto per poter riordinare',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('EAST'),
                              SizedBox(height: 10),
                              StandingsList(teams: eastPred),
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('WEST'),
                                SizedBox(height: 10),
                                StandingsList(teams: westPred),
                              ]),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'Update and exit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            print(westTeams);
                            print(westPred);
                            DatabaseService().updatePredictionsFromOrderedList(
                                profiles[widget.index].name, eastPred, westPred);
                            Navigator.popUntil(context, ModalRoute.withName('/mini_tb'));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class StandingsList extends StatefulWidget {
  final List<String> teams;

  StandingsList({Key key, this.teams}) : super(key: key);

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
                    decoration: BoxDecoration(color: Colors.grey),
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
