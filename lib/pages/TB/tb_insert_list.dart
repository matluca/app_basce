import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:flutter/material.dart';

class TBInsertList extends StatefulWidget {
  const TBInsertList({Key? key}) : super(key: key);

  @override
  _TBInsertListState createState() => _TBInsertListState();
}

class _TBInsertListState extends State<TBInsertList> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final columns = orientation == Orientation.portrait ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Chi sei?'),
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
                itemCount: tbParticipants.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/tb_pwd',
                              arguments: index);
                        },
                        title: Center(
                          child: Text(
                            tbParticipants[index].name,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/${tbParticipants[index].image}'),
                          radius: 23,
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
