import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('App Bascé Home'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/launcher.png'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {alertDialog(context);},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20,30,20,20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Biatch!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset('assets/profile2020.jpg'),
                SizedBox(height: 25),
                Menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.people),
            trailing: Icon(Icons.play_arrow),
            title: Text(
                'Profili',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                )
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile_list');
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(MdiIcons.podium),
            ),
            trailing: Icon(Icons.play_arrow),
            title: Text(
                "Albo d'oro",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18)
            ),
            onTap: () {
              Navigator.pushNamed(context, '/albo');
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(MdiIcons.basketball),
            trailing: Icon(Icons.play_arrow),
            title: Text(
              'Partecipa al Torneo Bascé',
              style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),),
            onTap: () {
              Navigator.pushNamed(context, '/wip');
            },
          ),
        ),
      ],
    );
  }
}


//Function which shows Alert Dialog
alertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text("App Bascé Info")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Versione: 1.3', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 10),
            Text('Creatore: Luca', style: TextStyle(color: Colors.grey[700]))
          ],
        ),
      );
    },
  );
}

//Function which shows Image
showImage(BuildContext context, String image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Image.asset(image),
          ),
        ),
      );
    },
  );
}
