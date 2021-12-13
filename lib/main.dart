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

  // For Android
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  // For Web
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyAkosczGLQBjng85sHD6kQoeX6T-1oLh1E",
  //     appId: "1:180543049748:web:58fa4e085f07100794d701",
  //     messagingSenderId: "180543049748",
  //     projectId: "minitb-rs",
  //     authDomain: "minitb-rs.firebaseapp.com",
  //     databaseURL: "https://minitb-rs.firebaseio.com",
  //     storageBucket: "minitb-rs.appspot.com",
  //   )
  // );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString(),
              textDirection: TextDirection.ltr);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppBasceLogin();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
            child: SizedBox(
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
  final Future<UserCredential?> _login =
      AuthService().signInWithEmailAndPassword();

  AppBasceLogin({Key? key}) : super(key: key);

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
          return const AppBasce();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
            child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}

class AppBasce extends StatelessWidget {
  const AppBasce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const Home(),
        '/loading': (context) => const Loading(),
        '/wip': (context) => const WorkInProgress(),
        '/profile_list': (context) => const ProfileList(),
        '/profile': (context) => const PersonalProfile(),
        '/albo': (context) => const Albo(),
        '/albo_mini': (context) => const AlboMini(),
        '/year_stats': (context) => const YearStats(),
        '/year_stats_mini': (context) => const YearStatsMini(),
        '/mini_tb': (context) => const MiniTB(),
        '/minitb_insert_list': (context) => const MiniTBInsertList(),
        '/minitb_insert': (context) => const MiniTBInsertPrediction(),
        '/minitb_update': (context) => const MiniTBUpdate(),
        '/minitb_predictions': (context) => const MiniTBPredictions(),
        '/minitb_standings': (context) => const MiniTBStandings(),
        '/minitb_pwd': (context) => const MiniTBInsertPassword(),
      },
    );
  }
}
