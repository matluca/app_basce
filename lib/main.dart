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
import 'package:appbasce/pages/miniTB/minitb_nba_standings.dart';
import 'package:appbasce/pages/miniTB/miniTB_insert_pwd.dart';
import 'package:appbasce/pages/TB/tb.dart';
import 'package:appbasce/pages/TB/tb_insert_list.dart';
import 'package:appbasce/pages/TB/tb_insert_pwd.dart';
import 'package:appbasce/pages/TB/tb_insert.dart';
import 'package:appbasce/pages/TB/tb_insert_admin.dart';
import 'package:appbasce/pages/TB/tb_insert_one.dart';
import 'package:appbasce/pages/TB/tb_insert_one_admin.dart';
import 'package:appbasce/pages/TB/tb_view_results.dart';
import 'package:appbasce/pages/TB/tb_insert_bracket.dart';
import 'package:appbasce/pages/TB/tb_change_seeds.dart';
import 'package:appbasce/pages/TB/tb_change_extra.dart';
import 'package:appbasce/pages/TB/tb_change_bracket_deadline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'configure_non_web.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // configure URL strategy for web app
  configureApp();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  // Initialize Firebase
  final Future<FirebaseApp> _initialization = initializeApp();

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
        '/minitb_nba_standings': (context) => const MiniTBNBAStandings(),
        '/minitb_pwd': (context) => const MiniTBInsertPassword(),
        '/tb': (context) => const TB(),
        '/tb_insert_list': (context) => const TBInsertList(),
        '/tb_pwd': (context) => const TBInsertPassword(),
        '/tb_insert': (context) => const TBInsertPrediction(),
        '/tb_insert_admin': (context) => const TBInsertPredictionAdmin(),
        '/tb_insert_one': (context) => const TBInsertOnePrediction(),
        '/tb_insert_one_admin': (context) => const TBInsertOnePredictionAdmin(),
        '/tb_view_results': (context) => const TBViewResults(),
        '/tb_insert_bracket': (context) => const TBInsertBracket(),
        '/tb_change_bracket_deadline': (context) => const TBChangeBracketDeadline(),
        '/tb_change_seeds': (context) => const TBChangeSeeds(),
        '/tb_change_extra': (context) => const TBChangeExtra(),
      },
    );
  }
}
