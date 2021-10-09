import 'package:appbasce/classes/miniTBStat_class.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Map iconMapMini = {
  iMini : MdiIcons.romanNumeral1,
};

class AlboMini extends StatefulWidget {
  @override
  _AlboMiniState createState() => _AlboMiniState();
}

class _AlboMiniState extends State<AlboMini> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Albo d'oro MiniTB"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5,35,5,10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/albo.png'), height: 150),
              SizedBox(height: 30),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: miniTBStats.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/year_stats_mini', arguments: index);
                        },
                        title: Center(
                          child: Text(
                            '${miniTBStats[index].label} MiniTB (${miniTBStats[index].year.toString()})',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        leading: Icon(iconMapMini[miniTBStats[index]], size: 40),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/${miniTBStats[index].first[0].image}'),
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
              //SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

