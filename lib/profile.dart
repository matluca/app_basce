import 'package:appbasce/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {

  Profile profile;

  @override
  Widget build(BuildContext context) {

    profile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Profilo di ${profile.name}'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[200],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/${profile.image}'),
                radius: 70,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            Text(
              profile.name,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(MdiIcons.trophy, size: 40),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TORNEI BASCÉ VINTI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      profile.tournamentYears.length==0 ? '${profile.tournaments.toString()}' : '${profile.tournaments.toString()}  ${profile.tournamentYears.toString()}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(MdiIcons.reorderHorizontal, size: 30),
                Icon(MdiIcons.dragHorizontalVariant, size: 30),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'BRACKET VINTI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      profile.brackets.toString(),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(MdiIcons.numeric4Circle, size: 30),
                Icon(MdiIcons.numeric2CircleOutline, size: 30),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TURNI VINTI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      profile.rounds.toString(),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

