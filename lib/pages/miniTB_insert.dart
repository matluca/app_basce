import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/services/database.dart';

class MiniTBInsertPrediction extends StatefulWidget {
  @override
  _MiniTBInsertPredictionState createState() => _MiniTBInsertPredictionState();
}

class _MiniTBInsertPredictionState extends State<MiniTBInsertPrediction> {
  @override
  Widget build(BuildContext context) {
    int screen = ModalRoute.of(context).settings.arguments;
    final controller = PageController(
      initialPage: screen,
    );

    //List<Widget> pages = List.generate(yearStats.length, (index) => Page(screen: index));
    List<Widget> _createChildren() {
      return new List<Widget>.generate(profiles.length, (int index) {
        return InsertPredictionPage(screen: index);
      });
    }

    return PageView(
      controller: controller,
      children: _createChildren(),
    );
  }
}

class InsertPredictionPage extends StatefulWidget {
  final int screen;
  const InsertPredictionPage ({Key key, this.screen}): super(key: key);
  @override
  _InsertPredictionPageState createState() => _InsertPredictionPageState();
}

class _InsertPredictionPageState extends State<InsertPredictionPage> {
  @override
  Widget build(BuildContext context) {

    DatabaseService().updatePredictions(profiles[widget.screen].name, new List<int>.filled(16,0), new List<int>.filled(16,0));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Inserisci predizioni: ${profiles[widget.screen].name}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/'));},
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
    );
  }
}


