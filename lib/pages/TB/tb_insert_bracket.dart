import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/tb_bracket_class.dart';

class TBInsertBracket extends StatefulWidget {
  const TBInsertBracket({Key? key}) : super(key: key);

  @override
  _TBInsertBracketState createState() => _TBInsertBracketState();
}

class _TBInsertBracketState extends State<TBInsertBracket> {
  @override
  Widget build(BuildContext context) {
    TBBracketId bracket = ModalRoute.of(context)!.settings.arguments as TBBracketId;
    return TBInsertBracketPage(
        key: const Key("TBInsertOnePredictionPage"), bracket: bracket);
  }
}

class TBInsertBracketPage extends StatefulWidget {
  final TBBracketId bracket;

  const TBInsertBracketPage({Key? key, required this.bracket}) : super(key: key);

  @override
  _TBInsertBracketPageState createState() => _TBInsertBracketPageState();
}

class _TBInsertBracketPageState extends State<TBInsertBracketPage> {
  final _formKey = GlobalKey<FormState>();

  Widget _insertTeam(List<String> teams, String key) {
    return TextFormField(
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
        ),
      ),
      initialValue: widget.bracket.bracket[key] ?? teams[0],
      onChanged: (val) {
        setState(() {
          widget.bracket.bracket[key] = val;
          _formKey.currentState!.validate();
        });
      },
      validator: (val) {
        if (!teams.contains(val)) {
          return 'Error';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseServiceTB().tbSeeds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map tbSeeds = snapshot.data as Map;
          widget.bracket.bracket['W18'] ??= tbSeeds['W1'];
          widget.bracket.bracket['W45'] ??= tbSeeds['W4'];
          widget.bracket.bracket['W36'] ??= tbSeeds['W3'];
          widget.bracket.bracket['W27'] ??= tbSeeds['W2'];
          widget.bracket.bracket['W1458'] ??= tbSeeds['W1'];
          widget.bracket.bracket['W2367'] ??= tbSeeds['W2'];
          widget.bracket.bracket['W'] ??= tbSeeds['W1'];
          widget.bracket.bracket['E18'] ??= tbSeeds['E1'];
          widget.bracket.bracket['E45'] ??= tbSeeds['E4'];
          widget.bracket.bracket['E36'] ??= tbSeeds['E3'];
          widget.bracket.bracket['E27'] ??= tbSeeds['E2'];
          widget.bracket.bracket['E1458'] ??= tbSeeds['E1'];
          widget.bracket.bracket['E2367'] ??= tbSeeds['E2'];
          widget.bracket.bracket['E'] ??= tbSeeds['E1'];
          widget.bracket.bracket['F'] ??= tbSeeds['W'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: const Text('"Name" Inserisci bracket'),
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
            body: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                              DataColumn(label: Container()),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W1'])),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(Text(tbSeeds['E1'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W8'])),
                                DataCell(_insertTeam([tbSeeds['W1'], tbSeeds['W8']], 'W18')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([tbSeeds['E1'], tbSeeds['E8']], 'E18')),
                                DataCell(Text(tbSeeds['E8'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W4'])),
                                DataCell(_insertTeam([tbSeeds['W4'], tbSeeds['W5']], 'W45')),
                                DataCell(_insertTeam([widget.bracket.bracket['W18'] ?? tbSeeds['W1'], widget.bracket.bracket['W45'] ?? tbSeeds['W4']], 'W1458')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([widget.bracket.bracket['E18'] ?? tbSeeds['E1'], widget.bracket.bracket['E45'] ?? tbSeeds['E4']], 'E1458')),
                                DataCell(_insertTeam([tbSeeds['E4'], tbSeeds['E5']], 'E45')),
                                DataCell(Text(tbSeeds['E4'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W5'])),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([widget.bracket.bracket['W1458'] ?? tbSeeds['W1'], widget.bracket.bracket['W2367'] ?? tbSeeds['W2']], 'W')),
                                DataCell.empty,
                                DataCell(_insertTeam([widget.bracket.bracket['E1458'] ?? tbSeeds['E1'], widget.bracket.bracket['E2367'] ?? tbSeeds['E2']], 'E')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(Text(tbSeeds['E5'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W3'])),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([widget.bracket.bracket['W'] ?? tbSeeds['W1'], widget.bracket.bracket['E'] ?? tbSeeds['E1']], 'F')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(Text(tbSeeds['E3'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W6'])),
                                DataCell(_insertTeam([tbSeeds['W3'], tbSeeds['W6']], 'W36')),
                                DataCell(_insertTeam([widget.bracket.bracket['W27'] ?? tbSeeds['W2'], widget.bracket.bracket['W36'] ?? tbSeeds['W3']], 'W2367')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([widget.bracket.bracket['E27'] ?? tbSeeds['E2'], widget.bracket.bracket['E36'] ?? tbSeeds['E3']], 'E2367')),
                                DataCell(_insertTeam([tbSeeds['E3'], tbSeeds['E6']], 'E36')),
                                DataCell(Text(tbSeeds['E6'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W2'])),
                                DataCell(_insertTeam([tbSeeds['W2'], tbSeeds['W7']], 'W27')),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(_insertTeam([tbSeeds['E2'], tbSeeds['E7']], 'E27')),
                                DataCell(Text(tbSeeds['E2'])),
                              ]),
                              DataRow(cells: [
                                DataCell(Text(tbSeeds['W7'])),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(Text(tbSeeds['E7'])),
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
                            if (_formKey.currentState!.validate()) {
                              DatabaseServiceTB().updateBracket(widget.bracket.name, widget.bracket.bracket);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/tb_insert'));
                            }
                          },
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
      },
    );
  }
}
