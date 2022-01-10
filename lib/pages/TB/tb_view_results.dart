import 'package:appbasce/classes/tb_bracket_class.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';

class TBViewResults extends StatefulWidget {
  const TBViewResults({Key? key}) : super(key: key);

  @override
  _TBViewResultsState createState() => _TBViewResultsState();
}

class _TBViewResultsState extends State<TBViewResults> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServiceTB().pwds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TBPwd> pwds = snapshot.data as List<TBPwd>;
          return FutureBuilder(
            future: DatabaseServiceTB().allPredictionsAfterDeadline,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String,List<TBPred>> predictions = snapshot.data as Map<String,List<TBPred>>;
                return FutureBuilder(
                  future: DatabaseServiceTB().tbBrackets,
                    builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String,Map<String,String>> brackets = snapshot.data as Map<String,Map<String,String>>;
                      return FutureBuilder(
                        future: DatabaseServiceTB().tbSeeds,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map tbSeeds = snapshot.data as Map;
                            return FutureBuilder(
                              future: DatabaseServiceTB().bracketDdl,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DateTime bracketDeadline = snapshot.data as DateTime;
                                  return Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: Colors.blue[400],
                                      title: const Text('Risultati'),
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
                                      scrollDirection: Axis.vertical,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Turni",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                DataTable(
                                                  columns: roundsColumns(pwds),
                                                  rows: roundsRows(predictions, pwds),
                                                ),
                                                const SizedBox(height: 30),
                                                const Text(
                                                  "Bracket",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                DataTable(
                                                  columns: bracketColumns(pwds),
                                                  //dataRowHeight: 30,
                                                  rows: bracketRows(brackets, pwds, tbSeeds, bracketDeadline),
                                                ),
                                                const SizedBox(height: 30),
                                                const Text(
                                                  "Classifica Finale",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                DataTable(
                                                  columns: standingsColumns(pwds),
                                                  //dataRowHeight: 30,
                                                  rows: standingsRows(predictions, brackets, pwds, tbSeeds, bracketDeadline),
                                                ),
                                              ],
                                            ),
                                          ),
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
        } else {
          return const Loading();
        }
      }
    );
  }
}

List<DataColumn> roundsColumns(List<TBPwd> pwds) {
  List<DataColumn> c = [
    const DataColumn(label: Text('Serie', style: TextStyle(fontWeight: FontWeight.bold))),
    const DataColumn(label: Text('Risultato', style: TextStyle(fontWeight: FontWeight.bold))),
  ];
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      c.add(DataColumn(label: Text(pwd.name, style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  return c;
}

List<DataRow> roundsRows(Map<String,List<TBPred>> predictions, List<TBPwd> pwds) {
  List<DataRow> r = [];
  for (var seriesPredictions in predictions.values) {
    List<DataCell> cells = [];
    TBPred reference = namedPrediction(seriesPredictions, "Admin")!;
    cells.add(DataCell(Text("${reference.homeTeam} - ${reference.awayTeam}")));
    cells.add(DataCell(Text("${reference.home} - ${reference.away}")));
    for (var pwd in pwds) {
      if (pwd.name != "Admin") {
        TBPred? pred = namedPrediction(seriesPredictions, pwd.name);
        if (pred == null) {
          cells.add(const DataCell(Text("- - -")));
        } else {
          cells.add(DataCell(Text("${pred.home} - ${pred.away}")));
        }
      }
    }
    DataRow row = DataRow(
      cells: cells,
    );
    r.add(row);
  }
  List<DataCell> malusCells = [
    const DataCell(Text('Malus', style: TextStyle(fontWeight: FontWeight.bold))),
    DataCell.empty,
  ];
  Map<String,double> maluses = roundsMaluses(predictions, pwds);
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      malusCells.add(DataCell(Text(maluses[pwd.name]!.toString(), style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  r.add(DataRow(cells: malusCells));
  List<DataCell> standingsCells = [
    const DataCell(Text('Classifica', style: TextStyle(fontWeight: FontWeight.bold))),
    DataCell.empty,
  ];
  Map<String,int> standings = roundsStandings(maluses);
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      standingsCells.add(DataCell(Text(standings[pwd.name]!.toString(), style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  r.add(DataRow(cells: standingsCells));
  return r;
}

List<DataColumn> bracketColumns(List<TBPwd> pwds) {
  List<DataColumn> c = [
    const DataColumn(label: Text('Squadra', style: TextStyle(fontWeight: FontWeight.bold))),
    const DataColumn(label: Text('Turni vinti', style: TextStyle(fontWeight: FontWeight.bold))),
  ];
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      c.add(DataColumn(label: Text(pwd.name, style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  return c;
}

List<DataRow> bracketRows(Map<String, Map<String,String>> brackets, List<TBPwd> pwds, Map seeds, DateTime bracketDeadline) {
  if (DateTime.now().isBefore(bracketDeadline)) {
    return [];
  }
  Map<String, Map<String,int>> roundsWon = {};
  for (var entry in brackets.entries) {
    roundsWon[entry.key] = bracketToRoundsWon(entry.value, seeds);
  }
  List<DataRow> r = [];
  for (var key in seeds.keys.toList()..sort()) {
    String team = seeds[key] as String;
    List<DataCell> cells = [];
    Map<String,int> reference = roundsWon['Admin']!;
    cells.add(DataCell(Text(team)));
    cells.add(DataCell(Text(reference[team].toString())));
    for (var pwd in pwds) {
     if (pwd.name != 'Admin') {
       Map<String,int> bracket = roundsWon[pwd.name] ?? noRoundsWon(seeds);
       cells.add(DataCell(Text(bracket[team].toString())));
     }
    }
    r.add(DataRow(cells: cells));
  }
  List<DataCell> malusCells = [
    const DataCell(Text('Malus', style: TextStyle(fontWeight: FontWeight.bold))),
    DataCell.empty,
  ];
  Map<String,int> maluses = bracketMaluses(roundsWon, pwds, seeds);
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      malusCells.add(DataCell(Text(maluses[pwd.name].toString(), style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  r.add(DataRow(cells: malusCells));
  List<DataCell> standingsCells = [
    const DataCell(Text('Classifica', style: TextStyle(fontWeight: FontWeight.bold))),
    DataCell.empty,
  ];
  Map<String,int> standings = bracketStandings(maluses);
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      standingsCells.add(DataCell(Text(standings[pwd.name]!.toString(), style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  r.add(DataRow(cells: standingsCells));
  return r;
}

List<DataColumn> standingsColumns(List<TBPwd> pwds) {
  List<DataColumn> c = [
    DataColumn(label: Container()),
  ];
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      c.add(DataColumn(label: Text(pwd.name, style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  return c;
}

List<DataRow> standingsRows(Map<String,List<TBPred>> predictions, Map<String, Map<String,String>> brackets, List<TBPwd> pwds, Map seeds, DateTime bracketDeadline) {
  if (DateTime.now().isBefore(bracketDeadline)) {
    return [];
  }
  Map<String,double> rMaluses = roundsMaluses(predictions, pwds);
  Map<String,int> rStandings = roundsStandings(rMaluses);
  Map<String, Map<String,int>> roundsWon = {};
  for (var entry in brackets.entries) {
    roundsWon[entry.key] = bracketToRoundsWon(entry.value, seeds);
  }
  Map<String,int> brMaluses = bracketMaluses(roundsWon, pwds, seeds);
  Map<String,int> brStandings = bracketStandings(brMaluses);
  Map<String,int> totalPoints = {};
  for (var pwd in pwds) {
    if (pwd.name != 'Admin') {
      totalPoints[pwd.name] = rStandings[pwd.name]! + brStandings[pwd.name]!;
    }
  }
  List<DataRow> r = [];
  List<DataCell> pointsCells = [
    const DataCell(Text('Punti classifica finale'))
  ];
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      pointsCells.add(DataCell(Text(totalPoints[pwd.name].toString())));
    }
  }
  r.add(DataRow(cells: pointsCells));
  Map<String,int> overallStandings = globalStandings(totalPoints);
  List<DataCell> standingsCells = [
    const DataCell(Text('Classifica finale', style: TextStyle(fontWeight: FontWeight.bold)))
  ];
  for (var pwd in pwds) {
    if (pwd.name != "Admin") {
      standingsCells.add(DataCell(Text(overallStandings[pwd.name].toString(), style: const TextStyle(fontWeight: FontWeight.bold))));
    }
  }
  r.add(DataRow(cells: standingsCells));
  return r;
}

Map<String,int> globalStandings(Map<String,int> totalPoints) {
  Map<String,int> standings = {};
  var sortedKeys = totalPoints.keys.toList(growable: false)
    ..sort((k1, k2) => totalPoints[k1]!.compareTo(totalPoints[k2]!));
  for (int i = 0; i < sortedKeys.length; i++) {
    standings[sortedKeys[i]] = i+1;
    if ((i>0) && (totalPoints[sortedKeys[i]] == totalPoints[sortedKeys[i-1]])) {
      standings[sortedKeys[i]] = standings[sortedKeys[i-1]]!;
    }
  }
  return standings;
}
