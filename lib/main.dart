import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appbasce/services/auth.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/pages/home.dart';
import 'package:appbasce/pages/wip.dart';
import 'package:appbasce/pages/profile_list.dart';
import 'package:appbasce/pages/profile.dart';
import 'package:appbasce/pages/albo.dart';
import 'package:appbasce/pages/albo_mini.dart';
import 'package:appbasce/pages/year_stats.dart';
import 'package:appbasce/pages/year_stats_mini.dart';
import 'package:appbasce/pages/miniTB/miniTB.dart';
import 'package:appbasce/pages/miniTB/miniTB_insert_list.dart';
import 'package:appbasce/pages/miniTB/miniTB_insert.dart';
import 'package:appbasce/pages/miniTB/miniTB_update.dart';
import 'package:appbasce/pages/miniTB/minitb_predictions.dart';
import 'package:appbasce/pages/miniTB/minitb_standings.dart';
import 'package:appbasce/pages/miniTB/miniTB_insert_pwd.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppBasceLogin();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
        ));
      },
    );
  }
}

class AppBasceLogin extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<UserCredential?> _login = AuthService().signInWithEmailAndPassword();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _login,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppBasce();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
        ));
      },
    );
  }
}


class AppBasce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => Home(),
        '/loading': (context) => Loading(),
        '/wip': (context) => WorkInProgress(),
        '/profile_list': (context) => ProfileList(),
        '/profile': (context) => PersonalProfile(),
        '/albo': (context) => Albo(),
        '/albo_mini': (context) => AlboMini(),
        '/year_stats': (context) => YearStats(),
        '/year_stats_mini': (context) => YearStatsMini(),
        '/mini_tb': (context) => MiniTB(),
        '/minitb_insert_list': (context) => MiniTBInsertList(),
        '/minitb_insert': (context) => MiniTBInsertPrediction(),
        '/minitb_update': (context) => MiniTBUpdate(),
        '/minitb_predictions': (context) => MiniTBPredictions(),
        '/minitb_standings': (context) => MiniTBStandings(),
        '/minitb_pwd': (context) => MiniTBInsertPassword(),
      },
    );
  }
}

