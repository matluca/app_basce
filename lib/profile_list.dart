import 'package:flutter/material.dart';

class Profile {
  String name; // the name of the person
  String image; // the location of the profile image

  Profile({this.name, this.image});
}

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  List<Profile> profiles = [
    Profile(name: 'Alessandro Arlandini', image: 'ale.jpg'),
    Profile(name: 'Carmelo Puliatti', image: 'melo.jpg'),
    Profile(name: 'Enrico Di Gaspero', image: 'enrico.jpg'),
    Profile(name: 'Fabio Marconi', image: 'fabio.jpg'),
    Profile(name: 'Gianluca Maguolo', image: 'gianluca.jpg'),
    Profile(name: 'Luca Mattiello', image: 'luca.jpg'),
    Profile(name: 'Matteo Camelia', image: 'teo.jpg'),
    Profile(name: 'Nicola Turchi', image: 'nic.jpg'),
    Profile(name: 'Yiwei Cao', image: 'yiwei.jpg')
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
                  Navigator.pushNamed(context, '/wip');
                },
                title: Text(
                  profiles[index].name,
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
