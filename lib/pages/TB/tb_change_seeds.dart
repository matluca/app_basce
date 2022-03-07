import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';

class TBChangeSeeds extends StatefulWidget {
  const TBChangeSeeds({Key? key}) : super(key: key);

  @override
  _TBChangeSeedsState createState() => _TBChangeSeedsState();
}

class _TBChangeSeedsState extends State<TBChangeSeeds> {
  @override
  Widget build(BuildContext context) {
    bool authorized = ModalRoute.of(context)!.settings.arguments as bool;
    return TBChangeSeedsPage(
        key: const Key("TBChangeSeedsPage"), authorized: authorized);
  }
}

class TBChangeSeedsPage extends StatefulWidget {
  final bool authorized;
  const TBChangeSeedsPage({Key? key, required this.authorized}) : super(key: key);

  @override
  _TBChangeSeedsPageState createState() => _TBChangeSeedsPageState();
}

class _TBChangeSeedsPageState extends State<TBChangeSeedsPage> {
  Map? newSeeds;
  final _formKey = GlobalKey<FormState>();

  List<DataRow> rows (Map seeds) {
    List<DataRow> r = [];
    for (var i=1; i<=8; i++) {
      r.add(DataRow(
        cells: [
          DataCell(Text('W$i')),
          DataCell(TextFormField(
            decoration: decoration(),
            initialValue: newSeeds!['W$i'],
            validator: (val) {
              if ((val == null) || (val.length != 3)) {
                return 'Team non valido';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                newSeeds!['W$i'] = val;
              });
            },
          )),
          DataCell(Text('E$i')),
          DataCell(TextFormField(
            decoration: decoration(),
            initialValue: newSeeds!['E$i'],
            validator: (val) {
              if ((val == null) || (val.length != 3)) {
                return 'Team non valido';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                newSeeds!['E$i'] = val;
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
      future: DatabaseServiceTB().tbSeeds,
      builder: (context, snapshot) {
        if (snapshot.hasData && widget.authorized) {
          Map seeds = snapshot.data as Map;
          newSeeds ??= seeds;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: const Text(
                  'Admin, cambia seeds'),
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
                      Form(
                        key: _formKey,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Container()),
                            DataColumn(label: Container(width: 50)),
                            DataColumn(label: Container()),
                            DataColumn(label: Container(width: 50)),
                          ],
                          rows: rows(seeds),
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
                            DatabaseServiceTB().updateSeeds(newSeeds!);
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
