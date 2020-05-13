import 'package:flutter/material.dart';
import 'package:appbasce/loading.dart';
import 'package:appbasce/home.dart';
import 'package:appbasce/wip.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      '/': (context) => Home(),
      '/loading': (context) => Loading(),
      '/wip': (context) => WorkInProgress(),
    },
  ));
}
