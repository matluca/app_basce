import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';

class TBViewSeries extends StatefulWidget {
  const TBViewSeries({Key? key}) : super(key: key);

  @override
  _TBViewSeriesState createState() => _TBViewSeriesState();
}

class _TBViewSeriesState extends State<TBViewSeries> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServiceTB().pwds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TBPwd> pwds = snapshot.data as List<TBPwd>;
          return FutureBuilder(
            future: DatabaseServiceTB().allPredictions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String,List<TBPred>> predictions = snapshot.data as Map<String,List<TBPred>>;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[400],
                    title: const Text('Predizioni turni'),
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
                    child: DataTable(
                      columns: columns(pwds),
                      rows: rows(predictions, pwds),
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

List<DataColumn> columns(List<TBPwd> pwds) {
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

List<DataRow> rows(Map<String,List<TBPred>> predictions, List<TBPwd> pwds) {
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
  return r;
}
