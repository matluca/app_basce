import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MiniTB extends StatefulWidget {
  @override
  _MiniTBState createState() => _MiniTBState();
}

class _MiniTBState extends State<MiniTB> {
  var beforeDeadline = DateTime.now().isBefore(deadline);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Mini TB per la Regular Season'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5,35,5,10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (!deadlineOn || beforeDeadline) ? InserisciPredizioni() : InserisciPredizioniMock(),
              SizedBox(height: 20),
              (deadlineOn && beforeDeadline) ? VisualizzaPredizioniMock() : VisualizzaPredizioni(),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.play_arrow),
                  title: Text(
                      "Aggiorna classifiche NBA reali",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18)
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/minitb_insert', arguments: miniTBParticipants.length-1);
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
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(MdiIcons.pencil),
        trailing: Icon(Icons.play_arrow),
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
        leading: Icon(MdiIcons.pencil),
        trailing: Icon(Icons.play_arrow),
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
        leading: Icon(MdiIcons.messageTextOutline),
        trailing: Icon(Icons.play_arrow),
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
        leading: Icon(MdiIcons.messageTextOutline),
        trailing: Icon(Icons.play_arrow),
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

