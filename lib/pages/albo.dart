import 'package:flutter/material.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Map iconMap = {
  i: MdiIcons.romanNumeral1,
  ii: MdiIcons.romanNumeral2,
  iii: MdiIcons.romanNumeral3,
  iv: MdiIcons.romanNumeral4,
  v: MdiIcons.romanNumeral5,
  vi: MdiIcons.romanNumeral6,
  vii: MdiIcons.romanNumeral7,
  viii: MdiIcons.romanNumeral8,
  ix: MdiIcons.romanNumeral9,
  x: MdiIcons.romanNumeral10
};

class Albo extends StatefulWidget {
  const Albo({Key? key}) : super(key: key);

  @override
  _AlboState createState() => _AlboState();
}

class _AlboState extends State<Albo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text("Albo d'oro"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 35, 5, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/albo.png'), height: 150),
              const SizedBox(height: 30),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: yearStats.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/year_stats',
                              arguments: index);
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
                        leading: Icon(iconMap[yearStats[index]], size: 40),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/${yearStats[index].first[0].image}'),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              //SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
