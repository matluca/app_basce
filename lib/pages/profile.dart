import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/pages/home.dart';
import 'package:dots_indicator/dots_indicator.dart';

Map tournamentMap = {
  2016: 'I',
  2017: 'II',
  2018: 'III',
  2019: 'IV',
  2020: 'V'
};

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

    List tournaments = List.generate(profiles[widget.screen].tournamentYears.length,
            (index) => tournamentMap[profiles[widget.screen].tournamentYears[index]]);
    List secondPlaces = List.generate(profiles[widget.screen].secondYears.length,
            (index) => tournamentMap[profiles[widget.screen].secondYears[index]]);
    List thirdPlaces = List.generate(profiles[widget.screen].thirdYears.length,
            (index) => tournamentMap[profiles[widget.screen].thirdYears[index]]);
    List brackets = List.generate(profiles[widget.screen].bracketYears.length,
            (index) => tournamentMap[profiles[widget.screen].bracketYears[index]]);
    List rounds = List.generate(profiles[widget.screen].roundsYears.length,
            (index) => tournamentMap[profiles[widget.screen].roundsYears[index]]);

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
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
                                tournaments.length == 0 ? tournaments.length.toString() :
                                '${tournaments.length}  (${tournaments.toString().substring(1, tournaments.toString().length-1)} TB)',
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
                                secondPlaces.length == 0 ? secondPlaces.length.toString() :
                                '${secondPlaces.length}  (${secondPlaces.toString().substring(1,secondPlaces.toString().length-1)} TB)',
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
                                thirdPlaces.length == 0 ? thirdPlaces.length.toString() :
                                '${thirdPlaces.length}  (${thirdPlaces.toString().substring(1,thirdPlaces.toString().length-1)} TB)',
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
                                brackets.length == 0 ? brackets.length.toString() :
                                '${brackets.length}  (${brackets.toString().substring(1,brackets.toString().length-1)} TB)',
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
                                rounds.length == 0 ? rounds.length.toString() :
                                '${rounds.length}  (${rounds.toString().substring(1,rounds.toString().length-1)} TB)',
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
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: DotsIndicator(
                dotsCount: profiles.length,
                position: widget.screen.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
