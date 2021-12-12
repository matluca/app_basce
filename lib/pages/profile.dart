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
  2020: 'V',
  2021: 'VI'
};

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {
    int screen = ModalRoute.of(context)!.settings.arguments as int;
    final controller = PageController(
      initialPage: screen,
    );

    //List<Widget> pages = List.generate(yearStats.length, (index) => Page(screen: index));
    List<Widget> _createChildren() {
      return List<Widget>.generate(profiles.length, (int index) {
        return ProfilePage(key: const Key("ProfilePage"), screen: index);
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
  const ProfilePage ({required Key key, required this.screen}): super(key: key);
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
        title: Text(profiles[widget.screen].name),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
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
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
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
                      const Divider(
                        thickness: 2,
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          const  SizedBox(width: 10),
                          const  Icon(MdiIcons.trophy, size: 40, color: Color(0xFFFFD700)),
                          const SizedBox(width: 50),
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
                                tournaments.isEmpty ? tournaments.length.toString() :
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
                      const SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          const Icon(MdiIcons.trophy, size: 40, color: Color(0xFFA9A9A9)),
                          const SizedBox(width: 50),
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
                                secondPlaces.isEmpty ? secondPlaces.length.toString() :
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
                      const SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          const Icon(MdiIcons.trophy, size: 40, color: Color(0xFFFCD7F32)),
                          const SizedBox(width: 50),
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
                                thirdPlaces.isEmpty ? thirdPlaces.length.toString() :
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
                      const SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          const Icon(MdiIcons.reorderHorizontal, size: 30),
                          const Icon(MdiIcons.dragHorizontalVariant, size: 30),
                          const SizedBox(width: 40),
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
                                brackets.isEmpty ? brackets.length.toString() :
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
                      const SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          const Icon(MdiIcons.numeric4Circle, size: 30),
                          const Icon(MdiIcons.numeric2CircleOutline, size: 30),
                          const SizedBox(width: 40),
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
                                rounds.isEmpty ? rounds.length.toString() :
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
              padding: const EdgeInsets.symmetric(vertical: 10),
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
