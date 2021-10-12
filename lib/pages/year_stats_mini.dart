import 'package:appbasce/classes/miniTBStat_class.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:dots_indicator/dots_indicator.dart';

class YearStatsMini extends StatefulWidget {
  @override
  _YearStatsMiniState createState() => _YearStatsMiniState();
}

class _YearStatsMiniState extends State<YearStatsMini> {
  @override
  Widget build(BuildContext context) {

    int screen = ModalRoute.of(context).settings.arguments;
    final controller = PageController(
      initialPage: screen,
    );

    List<Widget> _createChildren() {
      return new List<Widget>.generate(miniTBStats.length, (int index) {
        return YearPageMini(screen: index);
      });
    }

    return PageView(
      controller: controller,
      children: _createChildren(),
    );
  }
}

class YearPageMini extends StatefulWidget {
  final int screen;
  const YearPageMini ({Key key, this.screen}): super(key: key);
  @override
  _YearPageMiniState createState() => _YearPageMiniState();
}

class _YearPageMiniState extends State<YearPageMini> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${miniTBStats[widget.screen].label} MiniTB (${miniTBStats[widget.screen].year.toString()})'),
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
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            left: (MediaQuery.of(context).size.width-350)/2,
                            top: 110,
                            child: Image.asset('assets/podium.png', width: 350),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/${miniTBStats[widget.screen].first[0].image}'),
                            ),
                          ),
                          if (miniTBStats[widget.screen].second.length == 1) Positioned(
                            top: 40,
                            left: MediaQuery.of(context).size.width/2-150,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/${miniTBStats[widget.screen].second[0].image}'),
                            ),
                          ) else Positioned(
                            top: 60,
                            left: MediaQuery.of(context).size.width/2-180,
                            child: Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: miniTBStats[widget.screen].second.length,
                                itemBuilder: (context, index) {return
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: AssetImage('assets/${miniTBStats[widget.screen].second[index].image}'),
                                        radius: 30,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          if (miniTBStats[widget.screen].third.length == 0) Positioned(
                            top: 60,
                            right: 50,
                            child: Container(),
                          ) else Positioned(
                            top: 60,
                            right: MediaQuery.of(context).size.width/2-160,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/${miniTBStats[widget.screen].third[0].image}'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 180),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: DotsIndicator(
                dotsCount: miniTBStats.length,
                position: widget.screen.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

