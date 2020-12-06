import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/services/database.dart';
import 'package:provider/provider.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MiniTBPredictions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MiniTBPred>>.value(
      value: DatabaseService().preds,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text('Mini TB - Predizioni'),
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
          padding: EdgeInsets.fromLTRB(5,20,5,10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/${profiles[index].image}'),
                          radius: 23,
                        ),
                        SizedBox(width: 6),
                        Predictions(name: profiles[index].name),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Predictions extends StatefulWidget {
  final String name;

  Predictions({ Key key, this.name }) : super(key: key);

  @override
  _PredictionsState createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  @override
  Widget build(BuildContext context) {

    final ep = Provider.of<List<MiniTBPred>>(context);

    var east = {};
    var west = {};

    ep.forEach((pred) {
      if (pred.name == widget.name) {
        east = pred.east;
        west = pred.west;
      }
    });

    var eastStandings = buildStandings(east);
    var westStandings = buildStandings(west);

    return Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*0.8,
        child: Card(
          margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Column(
            children: [
              ListTile(
                title: Text('East'),
                subtitle: Text('$eastStandings'),
              ),
              ListTile(
                title: Text('West'),
                subtitle: Text('$westStandings'),
              ),
            ],
          ),
        )
    );
  }
}



