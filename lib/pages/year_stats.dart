import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:appbasce/classes/yearStat_class.dart';
import 'package:dots_indicator/dots_indicator.dart';

class YearStats extends StatefulWidget {
  const YearStats({Key? key}) : super(key: key);

  @override
  _YearStatsState createState() => _YearStatsState();
}

class _YearStatsState extends State<YearStats> {
  @override
  Widget build(BuildContext context) {

    int screen = ModalRoute.of(context)!.settings.arguments as int;
    final controller = PageController(
      initialPage: screen,
    );

    List<Widget> _createChildren() {
      return List<Widget>.generate(yearStats.length, (int index) {
        return YearPage(key: const Key("YearPage"), screen: index);
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
  const YearPage ({required Key key, required this.screen}): super(key: key);
  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${yearStats[widget.screen].label} Torneo Bascé (${yearStats[widget.screen].year.toString()})'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
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
                  padding: const EdgeInsets.fromLTRB(0, 45, 0, 10),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        clipBehavior: Clip.none, alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            left: (MediaQuery.of(context).size.width-350)/2,
                            top: 110,
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
                            left: MediaQuery.of(context).size.width/2-150,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/${yearStats[widget.screen].second[0].image}'),
                            ),
                          ) else Positioned(
                            top: 60,
                            left: MediaQuery.of(context).size.width/2-180,
                            child: SizedBox(
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
                                      const SizedBox(width: 5),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          if (yearStats[widget.screen].third.isEmpty) Positioned(
                            top: 60,
                            right: 50,
                            child: Container(),
                          ) else Positioned(
                            top: 60,
                            right: MediaQuery.of(context).size.width/2-160,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/${yearStats[widget.screen].third[0].image}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 180),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(height: 40, thickness: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(MdiIcons.reorderHorizontal, size: 30),
                            Icon(MdiIcons.dragHorizontalVariant, size: 30),
                            const SizedBox(width: 40),
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
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: (width - 140)/yearStats[widget.screen].bracket.length>65 ? 60 : ((width - 140)/yearStats[widget.screen].bracket.length-5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: yearStats[widget.screen].bracket.length,
                                      itemBuilder: (context, index) {return
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/${yearStats[widget.screen].bracket[index].image}'),
                                            radius: (width - 140)/yearStats[widget.screen].bracket.length>65 ? 30 : ((width - 140)/yearStats[widget.screen].bracket.length-5)/2,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(MdiIcons.numeric4Circle, size: 30),
                            Icon(MdiIcons.numeric2CircleOutline, size: 30),
                            const SizedBox(width: 40),
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
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: yearStats[widget.screen].rounds.length,
                                    itemBuilder: (context, index) {return
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage('assets/${yearStats[widget.screen].rounds[index].image}'),
                                          radius: 30,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if ((yearStats[widget.screen].profilePictures).isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            'IMMAGINI PROFILO',
                            style: TextStyle(
                              color: Colors.grey[700],
                              letterSpacing: 2,
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (yearStats[widget.screen].profilePictures).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                                child: Image.asset(yearStats[widget.screen].profilePictures[index]),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DotsIndicator(
                dotsCount: yearStats.length,
                position: widget.screen.toInt(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
