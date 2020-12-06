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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,20,15,10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('EAST'),
              SizedBox(height: 15),
              StandingForm(teams: eastTeams),
              SizedBox(height: 30),
              Text('WEST'),
              SizedBox(height: 15),
              StandingForm(teams: westTeams),
            ],
          ),
        ),
      ),
    );
  }
}

class StandingForm extends StatefulWidget {
  final List<String> teams;
  StandingForm({ Key key, this.teams }) : super(key: key);

  @override
  _StandingFormState createState() => _StandingFormState();
}

class _StandingFormState extends State<StandingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> positions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  // form values
  List<String> _currentPred; // = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    var teams = widget.teams;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: teams.length,
            itemBuilder: (context, index) {
              var team = teams[index];
              return TextFormField(
                decoration: new InputDecoration(labelText: '$team'),
                validator: (val) => val.isEmpty ? 'Please enter a prediction (1 - 15)' : null,
                onChanged: (val) => setState(() => _currentPred[index] = val),
              );
            },
          ),
          RaisedButton(
            color: Colors.red,
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentPred);
            },
          ),
        ],
      ),
    );
  }
}




