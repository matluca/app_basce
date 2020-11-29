import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MiniTB extends StatelessWidget {
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
              Card(
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
              ),
              SizedBox(height: 20),
              Card(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
