import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TBInsertOnePredictionAdmin extends StatefulWidget {
  const TBInsertOnePredictionAdmin({Key? key}) : super(key: key);

  @override
  _TBInsertOnePredictionAdminState createState() => _TBInsertOnePredictionAdminState();
}

class _TBInsertOnePredictionAdminState extends State<TBInsertOnePredictionAdmin> {
  @override
  Widget build(BuildContext context) {
    TBPredId predId = ModalRoute.of(context)!.settings.arguments as TBPredId;
    return TBInsertOnePredictionAdminPage(
        key: const Key("TBInsertOnePredictionAdminPage"), predId: predId);
  }
}

class TBInsertOnePredictionAdminPage extends StatefulWidget {
  final TBPredId predId;

  const TBInsertOnePredictionAdminPage({required Key key, required this.predId})
      : super(key: key);

  @override
  _TBInsertOnePredictionAdminPageState createState() =>
      _TBInsertOnePredictionAdminPageState();
}

class _TBInsertOnePredictionAdminPageState extends State<TBInsertOnePredictionAdminPage> {
  int? home;
  int? away;
  String homeTeam = "";
  String awayTeam = "";
  DateTime? deadline;
  TimeOfDay? time;

  Future pickDate(BuildContext context, DateTime startDeadline) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: startDeadline,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      deadline = newDate;
    });
  }

  Future pickTime(BuildContext context, TimeOfDay startTime) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!,
        );
      }
    );
    if (newTime == null) {
      return;
    }
    setState(() {
      time = newTime;
    });
  }

  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

  String format24hTime(TimeOfDay time) {
    DateTime dateTime = DateTime(0, 0, 0, time.hour, time.minute);
    DateFormat timeFormatter = DateFormat('HH:mm');
    return timeFormatter.format(dateTime);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseServiceTB().predictions(widget.predId.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TBPred> preds = snapshot.data as List<TBPred>;
            TBPred reference = TBPred("Admin", "-", "-", 0, 0, null);
            for (final p in preds) {
              if (p.name == "Admin") {
                reference = p;
              }
            }
            if (homeTeam == "") {
              homeTeam = reference.homeTeam;
            }
            if (awayTeam == "") {
              awayTeam = reference.awayTeam;
            }
            home ??= reference.home;
            away ??= reference.away;
            deadline ??= (reference.deadline != null) ? reference.deadline : DateTime.now();
            time ??= (reference.deadline != null) ? TimeOfDay.fromDateTime(reference.deadline!) : TimeOfDay.now();

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
                        Form(
                          key: _formKey,
                          child: DataTable(
                            columns: [DataColumn(label: Container()), DataColumn(label: Container(width: 150))],
                            rows: [
                              DataRow(cells: [
                                const DataCell(Text(
                                  "Home",
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        homeTeam = val;
                                      });
                                    },
                                    initialValue: reference.homeTeam,
                                    validator: (val) {
                                      if ((val == null) || (val.length != 3)) {
                                        return 'Team non valido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                              DataRow(cells: [
                                const DataCell(Text(
                                  "Away",
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        awayTeam = val;
                                      });
                                    },
                                    initialValue: reference.awayTeam,
                                    validator: (val) {
                                      if ((val == null) || (val.length != 3)) {
                                        return 'Team non valido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(
                                  homeTeam,
                                  style: const TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        var games = int.tryParse(val);
                                        if (games != null) {
                                          home = games;
                                        }
                                      });
                                    },
                                    initialValue: reference.home.toString(),
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
                                  awayTeam,
                                  style: const TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        var games = int.tryParse(val);
                                        if (games != null) {
                                          away = games;
                                        }
                                      });
                                    },
                                    initialValue: reference.away.toString(),
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
                                const DataCell(Text(
                                  "Deadline",
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(
                                  TextFormField(
                                    decoration: InputDecoration(hintText: dateFormatter.format(deadline!)),
                                    onTap: () => pickDate(context, deadline!),
                                  ),
                                ),
                              ]),
                              DataRow(cells: [
                                DataCell.empty,
                                DataCell(
                                  TextFormField(
                                    decoration: InputDecoration(hintText: format24hTime(time!)),
                                    onTap: () => pickTime(context, time!),
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
                            if (_formKey.currentState!.validate() && isValid(home, away)) {
                              DateTime d = DateTime(deadline!.year, deadline!.month, deadline!.day, time!.hour, time!.minute);
                              DatabaseServiceTB().updateAdminPredictions(
                                  widget.predId.id, widget.predId.name, homeTeam, awayTeam, home!, away!, d);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/tb_insert'));
                            }
                          },
                        ),
                        ErrorMessage(message: isValid(home, away) ? '' : 'Predizione invalida'),
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
