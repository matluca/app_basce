import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:dots_indicator/dots_indicator.dart';

class YearStats extends StatefulWidget {
  @override
  _YearStatsState createState() => _YearStatsState();
}

class _YearStatsState extends State<YearStats> {
  @override
  Widget build(BuildContext context) {

    int screen = ModalRoute.of(context).settings.arguments;
    final controller = PageController(
      initialPage: screen,
    );

    //List<Widget> pages = List.generate(yearStats.length, (index) => Page(screen: index));
    List<Widget> _createChildren() {
      return new List<Widget>.generate(yearStats.length, (int index) {
        return YearPage(screen: index);
      });
    }

    return PageView(
      controller: controller,
      children: _createChildren(),
    );
  }
}

class YearPage extends StatefulWidget {
  final int screen;
  const YearPage ({Key key, this.screen}): super(key: key);
  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${yearStats[widget.screen].label} Torneo Bascé (${yearStats[widget.screen].year.toString()})'),
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
          SizedBox(height: 30),
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
                  backgroundImage: AssetImage('assets/${yearStats[widget.screen].first[0].image}'),
                ),
              ),
              if (yearStats[widget.screen].second.length == 1) Positioned(
                top: 40,
                left: 50,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/${yearStats[widget.screen].second[0].image}'),
                ),
              ) else Positioned(
                top: 60,
                left: 30,
                child: Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: yearStats[widget.screen].second.length,
                    itemBuilder: (context, index) {return
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/${yearStats[widget.screen].second[index].image}'),
                            radius: 30,
                          ),
                          SizedBox(width: 5),
                        ],
                      );
                    },
                  ),
                ),
              ),
              if (yearStats[widget.screen].third.length == 0) Positioned(
                top: 60,
                right: 50,
                child: Container(),
              ) else Positioned(
                top: 60,
                right: 50,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/${yearStats[widget.screen].third[0].image}'),
                ),
              ),
            ],
          ),
          SizedBox(height: 200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 50, thickness: 2),
          ),
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
                        itemCount: yearStats[widget.screen].bracket.length,
                        itemBuilder: (context, index) {return
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/${yearStats[widget.screen].bracket[index].image}'),
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
                        itemCount: yearStats[widget.screen].rounds.length,
                        itemBuilder: (context, index) {return
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/${yearStats[widget.screen].rounds[index].image}'),
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
          SizedBox(height: 20),
          DotsIndicator(
            dotsCount: yearStats.length,
            position: widget.screen.toDouble(),
          ),
        ],
      ),
    );
  }
}

