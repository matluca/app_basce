import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/services/database.dart';

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
  const InsertPredictionPage ({Key key, this.index}): super(key: key);
  @override
  _InsertPredictionPageState createState() => _InsertPredictionPageState();
}

class _InsertPredictionPageState extends State<InsertPredictionPage> {
  @override
  Widget build(BuildContext context) {

    //DatabaseService().updatePredictions(profiles[widget.screen].name, new List<int>.filled(16,0), new List<int>.filled(16,0));

    var eastPred = ['ATL', 'BOS', 'BRK', 'CHI', 'CHO', 'CLE', 'DET', 'IND', 'MIA', 'MIL', 'NYK', 'ORL', 'PHI', 'TOR', 'WAS'];
    var westPred = ['DAL', 'DEN', 'GSW', 'HOU', 'LAC', 'LAL', 'MEM', 'MIN', 'NOP', 'OKC', 'PHO', 'POR', 'SAC', 'SAS', 'UTA'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${profiles[widget.index].name}, riordina le liste'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,20,15,10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('EAST'),
                        SizedBox(height: 15),
                        StandingsList(teams: eastPred),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('WEST'),
                          SizedBox(height: 15),
                          StandingsList(teams: westPred),
                        ]
                    ),
                  ],
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print(westTeams);
                    print(westPred);
                    DatabaseService().updatePredictionsFromOrderedList(profiles[widget.index].name, eastPred, westPred);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StandingsList extends StatefulWidget {
  final List<String> teams;
  StandingsList({ Key key, this.teams }) : super(key: key);

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
            maxHeight: MediaQuery.of(context).size.height,
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
            children: List.generate(
                teams.length, (index) {
                  return ListTile(
                    dense: true,
                    key: Key('$index'),
                    title: Container(
                      height: 30,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Center(child: Text('${index+1}: ${teams[index]}'))),
                  );
            }),
          ),
        ),
      ],
    );
  }
}
