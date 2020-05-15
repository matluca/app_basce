import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/yearStat_class.dart';

class YearStats extends StatefulWidget {
  @override
  _YearStatsState createState() => _YearStatsState();
}

class _YearStatsState extends State<YearStats> {
  @override
  Widget build(BuildContext context) {

    Stats stats =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${stats.label} Torneo Bascé (${stats.year.toString()})'),
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
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 50),
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: (MediaQuery.of(context).size.width-350)/2,
                top: 120,
                child: Image.asset('assets/podium.png', width: 350),
              ),
              Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/${stats.first[0].image}'),
                ),
              ),
              if (stats.second.length == 1) Positioned(
                top: 40,
                left: 50,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/${stats.second[0].image}'),
                ),
              ) else Positioned(
                top: 60,
                left: 30,
                child: Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: stats.second.length,
                    itemBuilder: (context, index) {return
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/${stats.second[index].image}'),
                            radius: 30,
                          ),
                          SizedBox(width: 5),
                        ],
                      );
                    },
                  ),
                ),
              ),
              if (stats.third.length == 0) Positioned(
                top: 60,
                right: 50,
                child: Container(),
              ) else Positioned(
                top: 60,
                right: 50,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/${stats.third[0].image}'),
                ),
              ),
            ],
          ),
          SizedBox(height: 200),
          Divider(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Row(
              children: <Widget>[
                Icon(MdiIcons.reorderHorizontal, size: 30),
                Icon(MdiIcons.dragHorizontalVariant, size: 30),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'VINCITORE BRACKET',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: stats.bracket.length,
                        itemBuilder: (context, index) {return
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/${stats.bracket[index].image}'),
                                radius: 30,
                              ),
                              SizedBox(width: 5),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Row(
              children: <Widget>[
                Icon(MdiIcons.numeric4Circle, size: 30),
                Icon(MdiIcons.numeric2CircleOutline, size: 30),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'VINCITORE TURNI',
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: stats.rounds.length,
                        itemBuilder: (context, index) {return
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/${stats.rounds[index].image}'),
                                radius: 30,
                              ),
                              SizedBox(width: 5),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
