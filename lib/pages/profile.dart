import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/pages/home.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {
    int screen = ModalRoute
        .of(context)
        .settings
        .arguments;
    final controller = PageController(
      initialPage: screen,
    );

    //List<Widget> pages = List.generate(yearStats.length, (index) => Page(screen: index));
    List<Widget> _createChildren() {
      return new List<Widget>.generate(profiles.length, (int index) {
        return ProfilePage(screen: index);
      });
    }

    return PageView(
      controller: controller,
      children: _createChildren(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final int screen;
  const ProfilePage ({Key key, this.screen}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${profiles[widget.screen].name}'),
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
                onTap: () {showImage(context, 'assets/${profiles[widget.screen].image}');},
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/${profiles[widget.screen].image}'),
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
                      profiles[widget.screen].tournamentYears.length == 0 ? profiles[widget.screen].tournamentYears.length.toString() :
                      '${profiles[widget.screen].tournamentYears.length}  (${profiles[widget.screen].tournamentYears.toString().substring(1,profiles[widget.screen].tournamentYears.toString().length-1)})',
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
                      profiles[widget.screen].secondYears.length == 0 ? profiles[widget.screen].secondYears.length.toString() :
                      '${profiles[widget.screen].secondYears.length}  (${profiles[widget.screen].secondYears.toString().substring(1,profiles[widget.screen].secondYears.toString().length-1)})',
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
                      profiles[widget.screen].thirdYears.length == 0 ? profiles[widget.screen].thirdYears.length.toString() :
                      '${profiles[widget.screen].thirdYears.length}  (${profiles[widget.screen].thirdYears.toString().substring(1,profiles[widget.screen].thirdYears.toString().length-1)})',
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
                      profiles[widget.screen].bracketYears.length == 0 ? profiles[widget.screen].bracketYears.length.toString() :
                      '${profiles[widget.screen].bracketYears.length}  (${profiles[widget.screen].bracketYears.toString().substring(1,profiles[widget.screen].bracketYears.toString().length-1)})',
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
                      profiles[widget.screen].roundsYears.length == 0 ? profiles[widget.screen].roundsYears.length.toString() :
                      '${profiles[widget.screen].roundsYears.length}  (${profiles[widget.screen].roundsYears.toString().substring(1,profiles[widget.screen].roundsYears.toString().length-1)})',
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
            SizedBox(height: 20),
            Center(
              child: DotsIndicator(
                dotsCount: profiles.length,
                position: widget.screen.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
