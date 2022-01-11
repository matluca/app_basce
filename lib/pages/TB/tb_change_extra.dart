import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';

class TBChangeExtra extends StatefulWidget {
  const TBChangeExtra({Key? key}) : super(key: key);

  @override
  _TBChangeExtraState createState() => _TBChangeExtraState();
}

class _TBChangeExtraState extends State<TBChangeExtra> {
  @override
  Widget build(BuildContext context) {
    bool authorized = ModalRoute.of(context)!.settings.arguments as bool;
    return TBChangeExtraPage(
        key: const Key("TBChangeExtraPage"), authorized: authorized);
  }
}

class TBChangeExtraPage extends StatefulWidget {
  final bool authorized;
  const TBChangeExtraPage({Key? key, required this.authorized}) : super(key: key);

  @override
  _TBChangeExtraPageState createState() => _TBChangeExtraPageState();
}

class _TBChangeExtraPageState extends State<TBChangeExtraPage> {
  Map<String,double>? newRounds;
  Map<String,double>? newBracket;
  final _formKey = GlobalKey<FormState>();

  List<DataRow> rows(List<TBPwd> pwds, Map<String,double> rounds, Map<String,double> bracket) {
    List<DataRow> r = [];
    for (var pwd in pwds) {
      String name = pwd.name;
      if (name == 'Admin') {
        continue;
      }
      r.add(DataRow(
        cells: [
          DataCell(Text(name)),
          DataCell(TextFormField(
            decoration: decoration(),
            initialValue: (rounds[name] ?? 0).toString(),
            validator: (val) {
              if (val == null) {
                return 'Valore non valido';
              }
              var r = double.tryParse(val);
              if (r == null) {
                return 'Valore non valido';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                var r = double.tryParse(val);
                if (r != null) {
                  newRounds![name] = r;
                }
              });
            },
          )),
          DataCell(TextFormField(
            decoration: decoration(),
            initialValue: (bracket[name] ?? 0).toString(),
            validator: (val) {
              if (val == null) {
                return 'Valore non valido';
              }
              var r = double.tryParse(val);
              if (r == null) {
                return 'Valore non valido';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                var r = double.tryParse(val);
                if (r != null) {
                  newBracket![name] = r;
                }
              });
            },
          )),
        ]
      ));
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseServiceTB().tbExtra,
      builder: (context, snapshot) {
        if (snapshot.hasData && widget.authorized) {
          List<Map<String,double>> extra = snapshot.data as List<Map<String,double>>;
          Map<String,double> extraRounds = extra[0];
          Map<String,double> extraBracket = extra[1];
          newRounds ??= extraRounds;
          newBracket ??= extraBracket;
          return StreamBuilder(
            stream: DatabaseServiceTB().pwds,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TBPwd> pwds = snapshot.data as List<TBPwd>;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[400],
                    title: const Text(
                        'Admin, assegna extra bonus/malus'),
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
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            const Text(
                              'Inserisci un numero positivo per un malus, negativo per un bonus',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Container()),
                                  const DataColumn(label: Text('Turni', style: TextStyle(fontSize: 20))),
                                  const DataColumn(label: Text('Bracket', style: TextStyle(fontSize: 20))),
                                ],
                                rows: rows(pwds, extraRounds, extraBracket),
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
                                if (_formKey.currentState!.validate()) {
                                  DatabaseServiceTB().updateExtra(newRounds!, newBracket!);
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/tb_insert_admin'));
                                }
                              },
                            ),
                          ],
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
      },
    );
  }
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
