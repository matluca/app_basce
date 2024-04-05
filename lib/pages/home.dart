import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('App Bascé Home'),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/launcher.png'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              alertDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(child: Image.asset('assets/profile2023.png'), width: 700),
                const SizedBox(height: 25),
                const Menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(MdiIcons.basketball),
            trailing: const Icon(Icons.play_arrow),
            title: Text(
              'Partecipa al Torneo Bascé',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/tb');
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(MdiIcons.playBoxMultiple),
            trailing: const Icon(Icons.play_arrow),
            title: Text(
              'Partecipa al Mini-TB per la RS',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/mini_tb');
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
            trailing: const Icon(Icons.play_arrow),
            title: Text("Albo d'oro",
                style: TextStyle(color: Colors.grey[700], fontSize: 18)),
            onTap: () {
              Navigator.pushNamed(context, '/albo');
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
            trailing: const Icon(Icons.play_arrow),
            title: Text("Albo d'oro MiniTB",
                style: TextStyle(color: Colors.grey[700], fontSize: 18)),
            onTap: () {
              Navigator.pushNamed(context, '/albo_mini');
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.people),
            trailing: const Icon(Icons.play_arrow),
            title: Text('Profili',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                )),
            onTap: () {
              Navigator.pushNamed(context, '/profile_list');
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
        title: const Center(child: Text("App Bascé Info")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Versione: 6.0.0', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 10),
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
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Image.asset(image),
        ),
      );
    },
  );
}
