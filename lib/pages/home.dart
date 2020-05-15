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
      ),
      drawer: DrawerMenu(),
      backgroundColor: Colors.blue[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 60),
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
            SizedBox(height: 40),
            Image.asset('assets/Logo.jpg'),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: () {showImage(context, 'assets/naismith.jpg');},
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/naismith.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
                'Profili',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                )
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile_list');
            },
          ),
          ListTile(
            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(MdiIcons.podium),
            ),
            title: Text("Albo d'oro", style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            onTap: () {
              Navigator.pushNamed(context, '/albo');
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.basketball),
            title: Text('Partecipa al Torneo Bascé', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            onTap: () {
              Navigator.pushNamed(context, '/wip');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(thickness: 1),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Info', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                onTap: () {
                  alertDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
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
            Text('Versione: 1.0', style: TextStyle(color: Colors.grey[700])),
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
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Image.asset(image),
      );
    },
  );
}
