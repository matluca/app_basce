import 'package:appbasce/classes/profile_class.dart';
import 'dart:math';
import 'dart:collection';

List<Profile> miniTBParticipants = [
  ale,
  enrico,
  fabio,
  luca,
  magu,
  melo,
  nic,
  teo,
  admin
];

List<String> sponsors = [
  "AT&T",
  "Taco Bell",
  "KIA",
  "Little Caesars",
  "Vance Refrigeration",
  "Wendy's",
  "Chick-fil-a"
];

class MiniTBPwd {
  final String name;
  final String pwd;

  MiniTBPwd(this.name, this.pwd);
}

class MiniTBPred {
  final String name;
  final Map east;
  final Map west;
  final String date;
  final Map wins;
  final String proxy_country;

  MiniTBPred(this.name, this.east, this.west, this.date, this.wins, this.proxy_country);
}

Map buildStandings(Map predictions) {
  var standings = {};
  for (int i = 1; i < 16; i++) {
    standings[i] = '';
  }
  predictions.forEach((key, value) {
    standings[value] = key;
  });
  return standings;
}

List<String> buildCurrentList(Map prediction) {
  List<String> p = List.filled(15, '');
  for (int i = 1; i < 16; i++) {
    for (MapEntry<dynamic, dynamic> entry in prediction.entries) {
      if (entry.value == i) {
        p[i - 1] = entry.key;
        break;
      }
    }
  }
  return p;
}

List<int> malus(MiniTBPred prediction, MiniTBPred reference) {
  int mEast = 0;
  prediction.east.keys.forEach((team) {
    int p = min(prediction.east[team] as int, 11);
    int r = min(reference.east[team] as int, 11);
    mEast = mEast + (p - r).abs();
  });
  int mWest = 0;
  for (var team in prediction.west.keys) {
    int p = min(prediction.west[team] as int, 11);
    int r = min(reference.west[team] as int, 11);
    mWest = mWest + (p - r).abs();
  }
  return [mEast, mWest];
}

String miniTBStandings(List<MiniTBPred> preds, MiniTBPred yesterday) {
  MiniTBPred reference = MiniTBPred("", {}, {}, "", {}, "");
  for (var i = 0; i < preds.length; i++) {
    if (preds[i].name == "Admin") {
      reference = preds[i];
    }
  }
  var standings = {};
  var eastStandings = {};
  var westStandings = {};
  var diff = {};
  for (int i = 0; i < preds.length; i++) {
    if (preds[i].name != "Admin") {
      int east = malus(preds[i], reference)[0];
      int west = malus(preds[i], reference)[1];
      int eastYesterday = malus(preds[i], yesterday)[0];
      int westYesterday = malus(preds[i], yesterday)[1];
      standings[preds[i].name] = east + west;
      int d = east + west - eastYesterday - westYesterday;
      diff[preds[i].name] = "(=)";
      if (d > 0) {
        diff[preds[i].name] = "(+${d})";
      } else if (d < 0) {
        diff[preds[i].name] = "(${d})";
      }
      eastStandings[preds[i].name] = east;
      westStandings[preds[i].name] = west;
    }
  }
  var sortedKeys = standings.keys.toList(growable: false)
    ..sort((k1, k2) => standings[k1].compareTo(standings[k2]));
  LinkedHashMap sortedStandings = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => standings[k]);
  LinkedHashMap sortedEastStandings = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => eastStandings[k]);
  LinkedHashMap sortedWestStandings = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => westStandings[k]);
  LinkedHashMap sortedDiffs = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => diff[k]);

  var msg = "";
  for (int i = 0; i < sortedKeys.length; i++) {
    msg = msg +
        sortedKeys[i] +
        ": " +
        sortedStandings.values.toList()[i].toString() +
        "  (E: " +
        sortedEastStandings.values.toList()[i].toString() +
        ", W: " +
        sortedWestStandings.values.toList()[i].toString() +
        ")" +
        "  " +
        sortedDiffs.values.toList()[i];
    if (i != sortedKeys.length - 1) {
      msg = msg + "\n";
    }
  }
  return msg;
}
