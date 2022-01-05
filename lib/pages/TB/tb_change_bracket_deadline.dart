import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TBChangeBracketDeadline extends StatefulWidget {
  const TBChangeBracketDeadline({Key? key}) : super(key: key);

  @override
  _TBChangeBracketDeadlineState createState() => _TBChangeBracketDeadlineState();
}

class _TBChangeBracketDeadlineState extends State<TBChangeBracketDeadline> {
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
    return FutureBuilder(
      future: DatabaseServiceTB().bracketDdl,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime bracketDeadline = snapshot.data as DateTime;

          deadline ??= bracketDeadline;
          time ??= TimeOfDay.fromDateTime(bracketDeadline);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: const Text(
                  'Admin, cambia deadline brackets'),
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
                          columns: [DataColumn(label: Container()), DataColumn(label: Container(width: 150))],
                          rows: [
                            DataRow(cells: [
                              const DataCell(Text(
                                "Deadline",
                                style: TextStyle(fontSize: 20),
                              )),
                              DataCell(
                                TextFormField(
                                  decoration: decoration(dateFormatter.format(deadline!)),
                                  onTap: () => pickDate(context, deadline!),
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              DataCell.empty,
                              DataCell(
                                TextFormField(
                                  decoration: decoration(format24hTime(time!)),
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
                          DateTime d = DateTime(deadline!.year, deadline!.month, deadline!.day, time!.hour, time!.minute);
                          DatabaseServiceTB().updateBracketDeadline(d);
                          Navigator.popUntil(
                              context, ModalRoute.withName('/tb_insert_admin'));
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

InputDecoration decoration([String? hintText]) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 3.0)
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 3.0),
    ),
    hintText: hintText,
  );
}
