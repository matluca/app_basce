import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(''),
              accountName: Text('App Bascé'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/Logo.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Info'),
              onTap: () {
                Navigator.pushNamed(context, '/wip');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Profili'),
              onTap: () {
                Navigator.pushNamed(context, '/profile_list');
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.trophy),
              title: Text("Albo d'oro"),
              onTap: () {
                Navigator.pushNamed(context, '/wip');
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.yellow[700]),
              title: Text('Partecipa al Torneo Bascé'),
              onTap: () {
                Navigator.pushNamed(context, '/wip');
              },
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Impostazioni'),
                  onTap: () {
                    Navigator.pushNamed(context, '/wip');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop),
              image: AssetImage('assets/Logo.jpg'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Welcome Biatch!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
