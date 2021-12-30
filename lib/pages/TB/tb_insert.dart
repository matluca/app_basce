import 'package:appbasce/services/database_TB.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/classes/tb_prediction_class.dart';

class TBInsertPrediction extends StatefulWidget {
  const TBInsertPrediction({Key? key}) : super(key: key);

  @override
  _TBInsertPredictionState createState() => _TBInsertPredictionState();
}

class _TBInsertPredictionState extends State<TBInsertPrediction> {
  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;
    return TBInsertPredictionPage(
        key: const Key("TBInsertPredictionPage"), profile: profile);
  }
}

class TBInsertPredictionPage extends StatefulWidget {
  final Profile profile;
  const TBInsertPredictionPage({required Key key, required this.profile})
      : super(key: key);

  @override
  _TBInsertPredictionPageState createState() => _TBInsertPredictionPageState();
}

class _TBInsertPredictionPageState extends State<TBInsertPredictionPage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final columns = orientation == Orientation.portrait ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
            '${widget.profile.name}, inserisci predizioni'),
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
          padding: const EdgeInsets.fromLTRB(5, 25, 5, 10),
          child: Column(
            children: <Widget>[
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (width - 30) / columns / 85,
                    crossAxisCount: columns),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tbRoundsIds.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          TBPredId arg = TBPredId(tbRoundsIds[index], widget.profile.name);
                          Navigator.pushNamed(context, '/tb_insert_one',
                              arguments: arg);
                        },
                        title: Center(
                          child: Text(
                            tbRoundsIds[index],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //trailing: Icon(Icons.play_arrow),
                      ),
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

