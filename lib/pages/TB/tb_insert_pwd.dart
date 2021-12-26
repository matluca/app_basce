import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database_TB.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';

class TBInsertPassword extends StatefulWidget {
  const TBInsertPassword({Key? key}) : super(key: key);

  @override
  _TBInsertPasswordState createState() => _TBInsertPasswordState();
}

class _TBInsertPasswordState extends State<TBInsertPassword> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return InsertPasswordPage(
        key: const Key("InsertPasswordPage"), index: index);
  }
}

class InsertPasswordPage extends StatefulWidget {
  final int index;

  const InsertPasswordPage({required Key key, required this.index})
      : super(key: key);

  @override
  _InsertPasswordPageState createState() => _InsertPasswordPageState();
}

class _InsertPasswordPageState extends State<InsertPasswordPage> {
  String pwd = 'thisisnottherealpassword';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServiceTB().pwds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TBPwd> pwds = snapshot.data as List<TBPwd>;
          String oldPwd = "";
          for (var i = 0; i < pwds.length; i++) {
            if (pwds[i].name == tbParticipants[widget.index].name) {
              oldPwd = pwds[i].pwd;
            }
          }
          String message;
          if (oldPwd == '') {
            message = 'Inserisci una nuova password; verrà ricordata in futuro';
          } else {
            message = 'Inserisci la tua password';
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: Text(
                  '${tbParticipants[widget.index].name}, inserisci la tua password'),
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            pwd = val;
                          });
                        },
                        validator: (val) {
                          if ((val == '') ||
                              ((oldPwd != '') && (val != oldPwd))) {
                            return 'Password vuota o errata';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (oldPwd == '') {
                          DatabaseServiceTB().updatePassword(
                              tbParticipants[widget.index].name, pwd);
                        }
                        Navigator.pushNamed(context, '/wip', //TODO: predictions page
                            arguments: widget.index);
                      }
                    },
                  ),
                ],
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
