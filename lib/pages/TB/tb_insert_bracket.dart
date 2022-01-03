import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';

class TBInsertBracket extends StatefulWidget {
  const TBInsertBracket({Key? key}) : super(key: key);

  @override
  _TBInsertBracketState createState() => _TBInsertBracketState();
}

class _TBInsertBracketState extends State<TBInsertBracket> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseServiceTB().tbSeeds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map tbSeeds = snapshot.data as Map;
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
                        DataTable(
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
                              const DataCell(Text('W18')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('E18')),
                              DataCell(Text(tbSeeds['E8'])),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(tbSeeds['W4'])),
                              const DataCell(Text('W45')),
                              const DataCell(Text('W1458')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('E1458')),
                              const DataCell(Text('E45')),
                              DataCell(Text(tbSeeds['E4'])),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(tbSeeds['W5'])),
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('W')),
                              DataCell.empty,
                              const DataCell(Text('E')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell(Text(tbSeeds['E5'])),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(tbSeeds['W3'])),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('F')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell(Text(tbSeeds['E3'])),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(tbSeeds['W6'])),
                              const DataCell(Text('W36')),
                              const DataCell(Text('W2367')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('E2367')),
                              const DataCell(Text('E36')),
                              DataCell(Text(tbSeeds['E6'])),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(tbSeeds['W2'])),
                              const DataCell(Text('W27')),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              const DataCell(Text('E27')),
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text(
                            'Confirm and exit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {},
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
