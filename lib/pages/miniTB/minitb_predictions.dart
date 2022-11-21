import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database_miniTB.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:appbasce/classes/profile_class.dart';

class MiniTBPredictions extends StatelessWidget {
  const MiniTBPredictions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: const Text('Mini TB - Predizioni'),
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
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/${admin.image}'),
                        radius: 23,
                      ),
                      const SizedBox(width: 6),
                      Predictions(
                          key: const Key("MiniTB predictions"),
                          prediction: reference,
                          reference: reference,
                          isReference: true),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: miniTBParticipants.length - 1,
                          itemBuilder: (context, index) {
                            MiniTBPred pred = MiniTBPred("", {}, {}, "", {});
                            for (var i = 0; i < preds.length; i++) {
                              if (preds[i].name ==
                                  miniTBParticipants[index].name) {
                                pred = preds[i];
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/${miniTBParticipants[index].image}'),
                                    radius: 23,
                                  ),
                                  const SizedBox(width: 6),
                                  Predictions(
                                      key: const Key("MiniTB predictions"),
                                      prediction: pred,
                                      reference: reference,
                                      isReference: false),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class Predictions extends StatefulWidget {
  final MiniTBPred prediction;
  final MiniTBPred reference;
  final bool isReference;

  const Predictions(
      {required Key key,
      required this.prediction,
      required this.reference,
      required this.isReference})
      : super(key: key);

  @override
  _PredictionsState createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  @override
  Widget build(BuildContext context) {
    var eastStandingsMap = buildStandings(widget.prediction.east);
    var westStandingsMap = buildStandings(widget.prediction.west);
    var eastReferenceMap = buildStandings(widget.reference.east);
    var westReferenceMap = buildStandings(widget.reference.west);
    var m = malus(widget.prediction, widget.reference);

    return Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Column(
            children: [
              ListTile(
                title: const Text('East'),
                subtitle: displayPrediction(
                    eastStandingsMap, eastReferenceMap, widget.isReference),
              ),
              ListTile(
                title: const Text('West'),
                subtitle: displayPrediction(
                    westStandingsMap, westReferenceMap, widget.isReference),
              ),
              widget.isReference
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Malus East: ${m[0]}, Malus West: ${m[1]}, Malus Tot: ${m[0] + m[1]}',
                        style: TextStyle(color: Colors.red[600]),
                      ),
                    ),
            ],
          ),
        ));
  }
}

Widget displayPrediction(Map pred, Map reference, bool isNotReference) {
  List<InlineSpan> teams = [];
  for (var e in pred.entries) {
    Color color = Colors.black54;
    FontWeight weight = FontWeight.normal;
    if ((e.value == reference[e.key]) && !isNotReference) {
      color = Colors.green;
      weight = FontWeight.bold;
    }
    if (e.key < 15) {
      teams.add(TextSpan(
          text: "${e.key}: ${e.value}, ",
          style: TextStyle(color: color, fontWeight: weight)));
    } else {
      teams.add(TextSpan(
          text: "${e.key}: ${e.value}",
          style: TextStyle(color: color, fontWeight: weight)));
    }
  }
  return RichText(text: TextSpan(children: teams));
}
