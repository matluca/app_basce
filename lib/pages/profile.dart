import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/pages/home.dart';

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {

    Profile profile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${profile.name}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () {showImage(context, 'assets/${profile.image}');},
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/${profile.image}'),
                  radius: 70,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              height: 50,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(MdiIcons.trophy, size: 40, color: Color(0xFFFFD700)),
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
                    Text(
                      profile.tournamentYears.length == 0 ? profile.tournamentYears.length.toString() :
                      '${profile.tournamentYears.length}  (${profile.tournamentYears.toString().substring(1,profile.tournamentYears.toString().length-1)})',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(MdiIcons.trophy, size: 40, color: Color(0xFFA9A9A9)),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SECONDI POSTI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      profile.secondYears.length == 0 ? profile.secondYears.length.toString() :
                      '${profile.secondYears.length}  (${profile.secondYears.toString().substring(1,profile.secondYears.toString().length-1)})',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(MdiIcons.trophy, size: 40, color: Color(0xFFFCD7F32)),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TERZI POSTI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      profile.thirdYears.length == 0 ? profile.thirdYears.length.toString() :
                      '${profile.thirdYears.length}  (${profile.thirdYears.toString().substring(1,profile.thirdYears.toString().length-1)})',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
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
                    Text(
                      profile.bracketYears.length == 0 ? profile.bracketYears.length.toString() :
                      '${profile.bracketYears.length}  (${profile.bracketYears.toString().substring(1,profile.bracketYears.toString().length-1)})',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
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
                    Text(
                      profile.roundsYears.length == 0 ? profile.roundsYears.length.toString() :
                      '${profile.roundsYears.length}  (${profile.roundsYears.toString().substring(1,profile.roundsYears.toString().length-1)})',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
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

