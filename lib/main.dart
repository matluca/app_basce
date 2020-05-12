import 'package:flutter/material.dart';
import 'package:appbasce/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Loading(),
      //'/home': (context) => Home(),
      //'/location': (context) => Profile(),
    },
  ));
}
