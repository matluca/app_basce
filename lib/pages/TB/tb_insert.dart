import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';

class TBInsertPrediction extends StatefulWidget {
  const TBInsertPrediction({Key? key}) : super(key: key);

  @override
  _TBInsertPredictionState createState() => _TBInsertPredictionState();
}

class _TBInsertPredictionState extends State<TBInsertPrediction> {
  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;
    return TBInsertPredictionPage(
        key: const Key("TBInsertPredictionPage"), profile: profile);
  }
}

class TBInsertPredictionPage extends StatefulWidget {
  final Profile profile;
  const TBInsertPredictionPage({required Key key, required this.profile})
      : super(key: key);

  @override
  _TBInsertPredictionPageState createState() => _TBInsertPredictionPageState();
}

class _TBInsertPredictionPageState extends State<TBInsertPredictionPage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final columns = orientation == Orientation.portrait ? 2 : 3;

    return FutureBuilder(
      future: DatabaseServiceTB().allPredictions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String,List<TBPred>> predictions = snapshot.data as Map<String,List<TBPred>>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: Text(
                  '${widget.profile.name}, inserisci predizioni'),
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
                padding: const EdgeInsets.fromLTRB(5, 25, 5, 10),
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (width - 30) / columns / 85,
                          crossAxisCount: columns),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 4),
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                TBPredId arg = TBPredId(tbRoundsIds[index], widget.profile.name);
                                Navigator.pushNamed(context, insertPagePath(widget.profile.name),
                                    arguments: arg);
                              },
                              title: Center(
                                child: Text(
                                  seriesTeams(predictions, tbRoundsIds[index], widget.profile.name),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              //trailing: Icon(Icons.play_arrow),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

String seriesTeams(Map<String,List<TBPred>> predictions, String id, String name) {
  if (name == "Admin") {
    return id;
  }
  TBPred reference = namedPrediction(predictions[id]!, "Admin")!;
  return "${reference.homeTeam} - ${reference.awayTeam}";
}

String insertPagePath(String name) {
  if (name == "Admin") {
    return "/tb_insert_one_admin";
  }
  return "/tb_insert_one";
}

