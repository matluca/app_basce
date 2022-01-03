import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class TB extends StatefulWidget {
  const TB({Key? key}) : super(key: key);

  @override
  _TBState createState() => _TBState();
}

class _TBState extends State<TB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: const Text('Torneo Bascé'),
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
              Card(
                child: ListTile(
                  leading: const Icon(MdiIcons.pencil),
                  trailing: const Icon(Icons.play_arrow),
                  title: Text(
                      "Inserisci predizioni turni",
                      style: TextStyle(
                          color: Colors.grey[700], fontSize: 18)),
                  onTap: () {
                    Navigator.pushNamed(context, '/tb_insert_list');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(MdiIcons.messageTextOutline),
                  trailing: const Icon(Icons.play_arrow),
                  title: Text(
                      "Visualizza predizioni turni",
                      style: TextStyle(
                          color: Colors.grey[700], fontSize: 18)),
                  onTap: () {
                    Navigator.pushNamed(context, '/tb_view_series');
                  },
                ),
              ),
              const SizedBox(height: 100),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  trailing: const Icon(Icons.play_arrow),
                  title: Text(
                      "Admin",
                      style: TextStyle(
                          color: Colors.grey[700], fontSize: 18)),
                  onTap: () {
                    Navigator.pushNamed(context, '/tb_pwd', arguments: 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InserisciPredizioni extends StatelessWidget {
  const InserisciPredizioni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(MdiIcons.pencil),
        trailing: const Icon(Icons.play_arrow),
        title: Text("Inserisci/Aggiorna predizione",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_insert_list');
        },
      ),
    );
  }
}

class InserisciPredizioniMock extends StatelessWidget {
  const InserisciPredizioniMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 0,
      child: ListTile(
        leading: const Icon(MdiIcons.pencil),
        trailing: const Icon(Icons.play_arrow),
        title: Text("Inserisci/Aggiorna predizione",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
      ),
    );
  }
}

class VisualizzaPredizioni extends StatelessWidget {
  const VisualizzaPredizioni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(MdiIcons.messageTextOutline),
        trailing: const Icon(Icons.play_arrow),
        title: Text("Visualizza predizioni",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_predictions');
        },
      ),
    );
  }
}

class VisualizzaPredizioniMock extends StatelessWidget {
  const VisualizzaPredizioniMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 0,
      child: ListTile(
        leading: const Icon(MdiIcons.messageTextOutline),
        trailing: const Icon(Icons.play_arrow),
        title: Text("Visualizza predizioni",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
      ),
    );
  }
}

class VisualizzaClassifica extends StatelessWidget {
  const VisualizzaClassifica({Key? key}) : super(key: key);

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
        title: Text("Visualizza classifica",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
        onTap: () {
          Navigator.pushNamed(context, '/minitb_standings');
        },
      ),
    );
  }
}

class VisualizzaClassificaMock extends StatelessWidget {
  const VisualizzaClassificaMock({Key? key}) : super(key: key);

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
        title: Text("Visualizza classifica",
            style: TextStyle(color: Colors.grey[700], fontSize: 18)),
      ),
    );
  }
}
