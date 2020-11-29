import 'package:flutter/material.dart';
import 'package:appbasce/pages/loading.dart';
import 'package:appbasce/pages/home.dart';
import 'package:appbasce/pages/wip.dart';
import 'package:appbasce/pages/profile_list.dart';
import 'package:appbasce/pages/profile.dart';
import 'package:appbasce/pages/albo.dart';
import 'package:appbasce/pages/year_stats.dart';
import 'package:appbasce/pages/miniTB.dart';
import 'package:appbasce/pages/miniTB_insert_list.dart';
import 'package:appbasce/pages/miniTB_insert.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      '/': (context) => Home(),
      '/loading': (context) => Loading(),
      '/wip': (context) => WorkInProgress(),
      '/profile_list': (context) => ProfileList(),
      '/profile': (context) => PersonalProfile(),
      '/albo': (context) => Albo(),
      '/year_stats': (context) => YearStats(),
      '/mini_tb': (context) => MiniTB(),
      '/minitb_insert_list': (context) => MiniTBInsertList(),
      '/minitb_insert': (context) => MiniTBInsertPrediction(),
    },
  ));
}
