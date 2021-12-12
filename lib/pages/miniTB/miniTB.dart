import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class MiniTB extends StatefulWidget {
  @override
  _MiniTBState createState() => _MiniTBState();
}

class _MiniTBState extends State<MiniTB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().ddl,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime ddlFromDB = snapshot.data as DateTime;
          bool beforeDeadline = DateTime.now().isBefore(ddlFromDB);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              title: const Text('Mini TB per la RS'),
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
                padding: const EdgeInsets.fromLTRB(5, 35, 5, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    beforeDeadline
                        ? InserisciPredizioni()
                        : InserisciPredizioniMock(),
                    beforeDeadline
                        ? VisualizzaClassificaMock()
                        : VisualizzaClassifica(),
                    beforeDeadline
                        ? VisualizzaPredizioniMock()
                        : VisualizzaPredizioni(),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.cloud_download),
                        trailing: const Icon(Icons.play_arrow),
                        title: Text(
                            "Aggiorna classifiche NBA reali automaticamente",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18)
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/minitb_update');
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        trailing: Icon(Icons.play_arrow),
                        title: Text(
                            "Aggiorna classifiche NBA reali manualmente",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18)
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/minitb_insert',
                              arguments: miniTBParticipants.length - 1);
                        },
                      ),
                    ),
                    const SizedBox(height: 80),
                    beforeDeadline
                        ? Text('Deadline $ddlFromDB', style: TextStyle(color: Colors.grey[800]))
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}

class InserisciPredizioni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(MdiIcons.pencil),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Inserisci/Aggiorna predizione",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_insert_list');
        },
      ),
    );
  }
}

class InserisciPredizioniMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 0,
      child: ListTile(
        leading: const Icon(MdiIcons.pencil),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Inserisci/Aggiorna predizione",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
      ),
    );
  }
}

class VisualizzaPredizioni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(MdiIcons.messageTextOutline),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Visualizza predizioni",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_predictions');
        },
      ),
    );
  }
}

class VisualizzaPredizioniMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 0,
      child: ListTile(
        leading: const Icon(MdiIcons.messageTextOutline),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Visualizza predizioni",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
      ),
    );
  }
}

class VisualizzaClassifica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: const Icon(MdiIcons.podium),
        ),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Visualizza classifica",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_standings');
        },
      ),
    );
  }
}

class VisualizzaClassificaMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 0,
      child: ListTile(
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: const Icon(MdiIcons.podium),
        ),
        trailing: const Icon(Icons.play_arrow),
        title: Text(
            "Visualizza classifica",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18)
        ),
      ),
    );
  }
}
