import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database.dart';
import 'package:http/http.dart' as http;
import 'package:appbasce/pages/loading.dart';

class MiniTBUpdate extends StatefulWidget {
  @override
  _MiniTBUpdateState createState() => _MiniTBUpdateState();
}

class _MiniTBUpdateState extends State<MiniTBUpdate> {
  Future<NBAStandings> futureNBAStandings;
  @override
  void initState() {
    super.initState();
    futureNBAStandings = getStandings();
  }
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<NBAStandings>(
        future: futureNBAStandings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var eastStandings = snapshot.data.eastStandings;
            var westStandings = snapshot.data.westStandings;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[400],
                title: Text('Classifiche da nba.com'),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.blue[200],
              body: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
                    child: Center(
                      child: Column(
                        children: [
                          Standings(east: eastStandings, west: westStandings),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Update and exit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                DatabaseService().updatePredictionsFromOrderedList(
                                    'Admin', eastStandings, westStandings);
                                Navigator.popUntil(context, ModalRoute.withName('/mini_tb'));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            return Text(snapshot.data.eastStandings.toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}

Future<NBAStandings> getStandings() async {
  final response = await http.get(Uri.http("data.nba.net", "10s/prod/v1/current/standings_conference.json"));
  if (response.statusCode == 200) {
    return NBAStandings.fromJSON(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load standings");
  }
}

class NBAStandings {
  final List<String> eastStandings;
  final List<String> westStandings;

  NBAStandings({this.eastStandings, this.westStandings});

  factory NBAStandings.fromJSON(Map<String, dynamic> json) {
    var east = json['league']['standard']['conference']['east'];
    var west = json['league']['standard']['conference']['west'];
    List<String> eastStandings = [];
    List<String> westStandings = [];
    for (int i=0; i<15; i++) {
      eastStandings.add(pacifyTricode(east[i]['teamSitesOnly']['teamTricode']));
      westStandings.add(pacifyTricode(west[i]['teamSitesOnly']['teamTricode']));
    }
    return NBAStandings(
      eastStandings: eastStandings,
      westStandings: westStandings,
    );
  }
}

String pacifyTricode(String code) {
  if (code == 'BKN') {
    return 'BRK';
  } else if (code == 'CHA') {
    return 'CHO';
  } else if (code == 'PHX') {
    return 'PHO';
  } else {
    return code;
  }
}

class Standings extends StatefulWidget {
  final List<String> east;
  final List<String> west;

  Standings({ Key key, this.east, this.west}) : super(key: key);

  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  @override
  Widget build(BuildContext context) {

    var eastStandings = buildStandingsFromList(widget.east).toString();
    eastStandings = eastStandings.substring(1, eastStandings.length-1);
    var westStandings = buildStandingsFromList(widget.west).toString();
    westStandings = westStandings.substring(1, westStandings.length-1);

    return Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*0.8,
        child: Card(
          margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Column(
            children: [
              ListTile(
                title: Text('East'),
                subtitle: Text('$eastStandings'),
              ),
              ListTile(
                title: Text('West'),
                subtitle: Text('$westStandings'),
              ),
            ],
          ),
        )
    );
  }
}

Map buildStandingsFromList(List<String> st) {
  var standings = {};
  for (int i = 1; i < 16; i++) {
    standings[i] = st[i-1];
  }
  return standings;
}


