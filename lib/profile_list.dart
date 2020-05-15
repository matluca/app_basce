import 'package:flutter/material.dart';

class Profile {
  String name; // the name of the person
  String image; // the location of the profile image
  List<int> tournamentYears = []; // years when won the tournament
  List<int> secondYears =[]; // years with second place
  List<int> thirdYears = []; // years with third place
  List<int> bracketYears = []; // years when won the bracket
  List<int> roundsYears; // years when won the 'rounds'

  Profile({this.name, this.image, this.tournamentYears, this.secondYears, this.thirdYears, this.bracketYears, this.roundsYears});
}

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  List<Profile> profiles = [
    Profile(name: 'Ale', image: 'ale.jpg', tournamentYears: [2018], secondYears: [2017],
        thirdYears: [], bracketYears: [2017,2018], roundsYears: [2018]),
    Profile(name: 'Enrico', image: 'enrico.jpg', tournamentYears: [], secondYears: [],
        thirdYears: [2019], bracketYears: [], roundsYears: []),
    Profile(name: 'Fabio', image: 'fabio.jpg', tournamentYears: [], secondYears: [],
        thirdYears: [2017], bracketYears: [2017], roundsYears: []),
    Profile(name: 'Luca', image: 'luca.jpg', tournamentYears: [], secondYears: [2019],
        thirdYears: [], bracketYears: [2019], roundsYears: []),
    Profile(name: 'Magu', image: 'gianluca.jpg', tournamentYears: [2016], secondYears: [2018], thirdYears: [], bracketYears: [2017,2018], roundsYears: []),
    Profile(name: 'Melo', image: 'melo.jpg', tournamentYears: [2017, 2019], secondYears: [],
        thirdYears: [2018], bracketYears: [2017], roundsYears: [2017,2019]),
    Profile(name: 'Nic', image: 'nic.jpg', tournamentYears: [], secondYears: [],
        thirdYears: [], bracketYears: [], roundsYears: []),
    Profile(name: 'Teo', image: 'teo.jpg', tournamentYears: [], secondYears: [],
        thirdYears: [], bracketYears: [], roundsYears: []),
    Profile(name: 'Yiwei', image: 'yiwei.jpg', tournamentYears: [], secondYears: [],
        thirdYears: [], bracketYears: [], roundsYears: [])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Profili'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[200],
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/profile', arguments: profiles[index]);
                },
                title: Text(
                  '${profiles[index].name}',
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${profiles[index].image}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
