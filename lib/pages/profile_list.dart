import 'package:flutter/material.dart';
import 'package:appbasce/classes/profile_class.dart';
import 'package:appbasce/pages/home.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final columns = orientation == Orientation.portrait ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Profili'),
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
              InkWell(
                  onTap: () {
                    showImage(context, 'assets/wethebasce.jpeg');
                  },
                  child: const Image(
                      image: AssetImage('assets/wethebasce.jpeg'), width: 200)),
              const SizedBox(height: 15),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (width - 30) / columns / 85,
                    crossAxisCount: columns),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile',
                              arguments: index);
                        },
                        title: Center(
                          child: Text(
                            profiles[index].name,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/${profiles[index].image}'),
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
