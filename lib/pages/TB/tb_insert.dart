import 'package:appbasce/classes/tb_bracket_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:intl/intl.dart';

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
          return FutureBuilder(
            future: DatabaseServiceTB().tbBrackets,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String,Map<String,String>> brackets = snapshot.data as Map<String,Map<String,String>>;
                Map<String,String> bracket = brackets[widget.profile.name] ?? {};
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
                          Card(
                            child: ListTile(
                              onTap: () {
                                TBBracketId arg = TBBracketId(widget.profile.name, bracket);
                                Navigator.pushNamed(context, "/tb_insert_bracket", arguments: arg);
                              },
                              title: Center(
                                child: Text(
                                  'Bracket',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
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
                                child: SeriesCard(
                                    key: const Key("SeriesCard"),
                                    predictions: predictions,
                                    name: widget.profile.name,
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
        } else {
          return const Loading();
        }
      }
    );
  }
}

class SeriesCard extends StatefulWidget {
  final Map<String,List<TBPred>> predictions;
  final String id;
  final String name;
  const SeriesCard({Key? key, required this.predictions, required this.id, required this.name}) : super(key: key);

  @override
  _SeriesCardState createState() => _SeriesCardState();
}

class _SeriesCardState extends State<SeriesCard> {
  @override
  Widget build(BuildContext context) {
    TBPred reference = namedPrediction(widget.predictions[widget.id]!, "Admin")!;
    if ((widget.name == "Admin") || (reference.deadline == null) || (DateTime.now().isBefore(reference.deadline!))) {
      return Card(
        child: ListTile(
          onTap: () {
            TBPredId arg = TBPredId(widget.id, widget.name);
            Navigator.pushNamed(context, "/tb_insert_one",
                arguments: arg);
          },
          title: Center(
            child: Text(
              seriesTeams(widget.predictions, widget.id, widget.name),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    } else {
      return Card(
        elevation: 0,
        color: Colors.grey,
        child: ListTile(
          title: Center(
            child: Text(
              seriesTeams(widget.predictions, widget.id, widget.name),
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
}

String seriesTeams(Map<String,List<TBPred>> predictions, String id, String name) {
  TBPred reference = namedPrediction(predictions[id]!, "Admin")!;
  final DateFormat dateFormatter = DateFormat('dd MMM, HH:mm');
  if ((name == "Admin") || (reference.deadline == null)) {
    return "${reference.homeTeam} - ${reference.awayTeam}";
  }
  return "${reference.homeTeam} - ${reference.awayTeam}\n${dateFormatter.format(reference.deadline!)}";
}
