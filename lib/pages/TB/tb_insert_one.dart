import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';

class TBInsertOnePrediction extends StatefulWidget {
  const TBInsertOnePrediction({Key? key}) : super(key: key);

  @override
  _TBInsertOnePredictionState createState() => _TBInsertOnePredictionState();
}

class _TBInsertOnePredictionState extends State<TBInsertOnePrediction> {
  @override
  Widget build(BuildContext context) {
    TBPredId predId = ModalRoute.of(context)!.settings.arguments as TBPredId;
    return TBInsertOnePredictionPage(
        key: const Key("TBInsertOnePredictionPage"), predId: predId);
  }
}

class TBInsertOnePredictionPage extends StatefulWidget {
  final TBPredId predId;

  const TBInsertOnePredictionPage({required Key key, required this.predId})
      : super(key: key);

  @override
  _TBInsertOnePredictionPageState createState() =>
      _TBInsertOnePredictionPageState();
}

class _TBInsertOnePredictionPageState extends State<TBInsertOnePredictionPage> {
  int? home;
  int? away;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseServiceTB().predictions(widget.predId.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TBPred> preds = snapshot.data as List<TBPred>;
            TBPred pred =
                TBPred(widget.predId.name, "-", "-", 0, 0, null);
            TBPred reference = TBPred("Admin", "-", "-", 0, 0, null);
            for (final p in preds) {
              if (p.name == widget.predId.name) {
                pred = p;
              }
              if (p.name == "Admin") {
                reference = p;
              }
            }
            pred.homeTeam = reference.homeTeam;
            pred.awayTeam = reference.awayTeam;
            home ??= pred.home;
            away ??= pred.away;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[400],
                title: Text('${widget.predId.name}, inserisci predizione'),
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Text(
                          'Inserisci il numero di vittorie nella serie',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Form(
                          key: _formKey,
                          child: DataTable(
                            columns: [DataColumn(label: Container()), DataColumn(label: Container(width: 50))],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(
                                  reference.homeTeam,
                                  style: const TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    decoration: decoration(),
                                    onChanged: (val) {
                                      setState(() {
                                        var games = int.tryParse(val);
                                        if (games != null) {
                                          home = games;
                                        }
                                      });
                                    },
                                    initialValue: pred.home.toString(),
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if ((val == null) || (val == '')) {
                                        return 'Numero di partite vuoto';
                                      }
                                      var games = int.tryParse(val);
                                      if ((games == null) || (games < 0) || (games > 4)) {
                                        return 'Numero di partite invalido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  reference.awayTeam,
                                  style: const TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    decoration: decoration(),
                                    onChanged: (val) {
                                      setState(() {
                                        var games = int.tryParse(val);
                                        if (games != null) {
                                          away = games;
                                        }
                                      });
                                    },
                                    initialValue: pred.away.toString(),
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if ((val == null) || (val == '')) {
                                        return 'Numero di partite vuoto';
                                      }
                                      var games = int.tryParse(val);
                                      if ((games == null) || (games < 0) || (games > 4)) {
                                        return 'Numero di partite invalido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text(
                            'Confirm and exit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if ((_formKey.currentState!.validate() && isValid(home, away) && DateTime.now().isBefore(reference.deadline!))
                            || (widget.predId.name == "Admin")) {
                              DatabaseServiceTB().updatePredictions(widget.predId.id, widget.predId.name, home!, away!);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/tb_insert'));
                            }
                          },
                        ),
                        ErrorMessage(message: errorMessage(home, away, reference.deadline!, widget.predId.name)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Loading();
          }
        });
  }
}

class ErrorMessage extends StatefulWidget {
  const ErrorMessage({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.message,
      style: const TextStyle(color: Colors.red),
    );
  }
}

bool isValid(int? home, int? away) {
  if ((home == null) || (away == null)) {
    return false;
  }
  if ((home < 0) || (away < 0)) {
    return false;
  }
  if ((home > 4) || (away > 4)) {
    return false;
  }
  if ((home != 4) && (away != 4)) {
    return false;
  }
  if ((home == 4) && (away == 4)) {
    return false;
  }
  return true;
}

InputDecoration decoration() {
  return const InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 3.0)
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 3.0),
    ),
  );
}

String errorMessage(int? home, int? away, DateTime deadline, String name) {
  if (name == "Admin") {
    return '';
  }
  if (!isValid(home, away)) {
    return 'Predizione invalida';
  }
  if (DateTime.now().isAfter(deadline)) {
    return 'Deadline superata';
  }
  return '';
}
