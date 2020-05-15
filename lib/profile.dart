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
              height: 50,
              color: Colors.grey[800],
            ),
//            Text(
//              profile.name,
//              style: TextStyle(
//                color: Colors.grey[800],
//                fontSize: 25,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//            SizedBox(height: 30),
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
                      profile.tournamentYears.length == 0 ? '${profile.tournamentYears.length.toString()}' : '${profile.tournamentYears.length.toString()}  ${profile.tournamentYears.toString()}',
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
                      profile.secondYears.length == 0 ? '${profile.secondYears.length.toString()}' : '${profile.secondYears.length.toString()}  ${profile.secondYears.toString()}',
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
                      profile.thirdYears.length == 0 ? '${profile.thirdYears.length.toString()}' : '${profile.thirdYears.length.toString()}  ${profile.thirdYears.toString()}',
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
                      profile.bracketYears.length == 0 ? '${profile.bracketYears.length.toString()}' : '${profile.bracketYears.length.toString()}  ${profile.bracketYears.toString()}',
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
                      profile.roundsYears.length == 0 ? '${profile.roundsYears.length.toString()}' : '${profile.roundsYears.length.toString()}  ${profile.roundsYears.toString()}',
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

