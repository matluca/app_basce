import 'package:flutter/material.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Albo extends StatefulWidget {
  @override
  _AlboState createState() => _AlboState();
}

TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches) {
  return branches[selectedOption];
}

class _AlboState extends State<Albo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Albo d'oro"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/albo.png'), height: 150),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: yearStats.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/year_stats', arguments: yearStats[index]);
                    },
                    title: Center(
                      child: Text(
                        '${yearStats[index].label} Torneo Bascé (${yearStats[index].year.toString()})',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    leading: case2(yearStats[index].label,
                        {
                          'I': Icon(MdiIcons.romanNumeral1),
                          'II': Icon(MdiIcons.romanNumeral2),
                          'III': Icon(MdiIcons.romanNumeral3),
                          'IV': Icon(MdiIcons.romanNumeral4)
                        }),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/${yearStats[index].first[0].image}'),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

