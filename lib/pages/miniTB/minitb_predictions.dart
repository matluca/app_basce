import 'package:appbasce/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/database.dart';
import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:appbasce/classes/profile_class.dart';

class MiniTBPredictions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().preds,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          List<MiniTBPred> preds = snapshot.data;
          MiniTBPred reference;
          for (var i=0; i<preds.length; i++) {
            if (preds[i].name == "Admin") {
              reference = preds[i];
            }
          }
          return Scaffold(
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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/${admin.image}'),
                        radius: 23,
                      ),
                      SizedBox(width: 6),
                      Predictions(prediction: reference, reference: reference, showMalus: false),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(5,0,5,10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: miniTBParticipants.length-1,
                          itemBuilder: (context, index) {
                            MiniTBPred pred;
                            for (var i=0; i<preds.length; i++) {
                              if (preds[i].name == miniTBParticipants[index].name) {
                                pred = preds[i];
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/${miniTBParticipants[index].image}'),
                                    radius: 23,
                                  ),
                                  SizedBox(width: 6),
                                  Predictions(prediction: pred, reference: reference, showMalus: true),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class Predictions extends StatefulWidget {
  final MiniTBPred prediction;
  final MiniTBPred reference;
  final bool showMalus;

  Predictions({ Key key, this.prediction, this.reference, this.showMalus }) : super(key: key);

  @override
  _PredictionsState createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  @override
  Widget build(BuildContext context) {

    var eastStandings = buildStandings(widget.prediction.east).toString();
    eastStandings = eastStandings.substring(1, eastStandings.length-1);
    var westStandings = buildStandings(widget.prediction.west).toString();
    westStandings = westStandings.substring(1, westStandings.length-1);
    var m = malus(widget.prediction, widget.reference);
    var showMalus = widget.showMalus;

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
              showMalus ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Malus East: ${m[0]}, Malus West: ${m[1]}, Malus Tot: ${m[0]+m[1]}',
                  style: TextStyle(color: Colors.red[600]),
                ),
              ) : Container(),
            ],
          ),
        )
    );
  }
}


