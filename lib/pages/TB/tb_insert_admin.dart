import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:intl/intl.dart';

class TBInsertPredictionAdmin extends StatefulWidget {
  const TBInsertPredictionAdmin({Key? key}) : super(key: key);

  @override
  _TBInsertPredictionAdminState createState() => _TBInsertPredictionAdminState();
}

class _TBInsertPredictionAdminState extends State<TBInsertPredictionAdmin> {
  @override
  Widget build(BuildContext context) {
    return const TBInsertPredictionAdminPage(
        key: Key("TBInsertPredictionAdminPage"));
  }
}

class TBInsertPredictionAdminPage extends StatefulWidget {
  const TBInsertPredictionAdminPage({required Key key})
      : super(key: key);

  @override
  _TBInsertPredictionAdminPageState createState() => _TBInsertPredictionAdminPageState();
}

class _TBInsertPredictionAdminPageState extends State<TBInsertPredictionAdminPage> {
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
              title: const Text(
                  'Admin, gestisci predizioni'),
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
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "/tb_change_seeds");
                        },
                        title: Center(
                          child: Text(
                            'Cambia seeds',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "/tb_change_bracket_deadline");
                        },
                        title: Center(
                          child: Text(
                            'Cambia deadline brackets',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          child: SeriesCardAdmin(
                              key: const Key("SeriesCard"),
                              predictions: predictions,
                              id: tbRoundsIds[index]
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

class SeriesCardAdmin extends StatefulWidget {
  final Map<String,List<TBPred>> predictions;
  final String id;
  const SeriesCardAdmin({Key? key, required this.predictions, required this.id}) : super(key: key);

  @override
  _SeriesCardAdminState createState() => _SeriesCardAdminState();
}

class _SeriesCardAdminState extends State<SeriesCardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          TBPredId arg = TBPredId(widget.id, "Admin");
          Navigator.pushNamed(context, "/tb_insert_one_admin",
              arguments: arg);
        },
        title: Center(
          child: Text(
            seriesTeamsAdmin(widget.predictions, widget.id),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

String seriesTeamsAdmin(Map<String,List<TBPred>> predictions, String id) {
  TBPred reference = namedPrediction(predictions[id]!, "Admin")!;
  return "$id\n${reference.homeTeam} - ${reference.awayTeam}";
}
