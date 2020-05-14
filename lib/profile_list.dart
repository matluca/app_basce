import 'package:flutter/material.dart';

class Profile {
  String name; // the name of the person
  String image; // the location of the profile image
  int tournaments; // number of TBs won
  List<int> tournamentYears = [];
  int brackets; // number of brackets won
  int rounds; // number of 'rounds' won

  Profile({this.name, this.image, this.tournaments, this.tournamentYears, this.brackets, this.rounds});
}

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  List<Profile> profiles = [
    Profile(name: 'Alessandro Arlandini', image: 'ale.jpg', tournaments: 1, tournamentYears: [2018], brackets: 0, rounds: 0),
    Profile(name: 'Carmelo Puliatti', image: 'melo.jpg', tournaments: 2, tournamentYears: [2017, 2019], brackets: 0, rounds: 0),
    Profile(name: 'Enrico Di Gaspero', image: 'enrico.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0),
    Profile(name: 'Fabio Marconi', image: 'fabio.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0),
    Profile(name: 'Gianluca Maguolo', image: 'gianluca.jpg', tournaments: 1, tournamentYears: [2016], brackets: 0, rounds: 0),
    Profile(name: 'Luca Mattiello', image: 'luca.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0),
    Profile(name: 'Matteo Camelia', image: 'teo.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0),
    Profile(name: 'Nicola Turchi', image: 'nic.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0),
    Profile(name: 'Yiwei Cao', image: 'yiwei.jpg', tournaments: 0, tournamentYears: [], brackets: 0, rounds: 0)
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
