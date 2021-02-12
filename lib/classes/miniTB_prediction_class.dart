import 'package:appbasce/classes/profile_class.dart';
import 'dart:math';
import 'dart:collection';

List<Profile> miniTBParticipants = [ale, enrico, luca, magu, melo, nic, teo, admin];

class MiniTBPwd {
  final String name;
  final String pwd;

  MiniTBPwd({this.name, this.pwd});
}

class MiniTBPred {
  final String name;
  final Map east;
  final Map west;

  MiniTBPred({this.name, this.east, this.west});
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
  List<String> p = new List.filled(15, '');
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
    mEast = mEast + (p-r).abs();
  });
  int mWest = 0;
  prediction.west.keys.forEach((team) {
    int p = min(prediction.west[team] as int, 11);
    int r = min(reference.west[team] as int, 11);
    mWest = mWest + (p-r).abs();
  });
  return [mEast, mWest];
}

String miniTBStandings(List<MiniTBPred> preds) {
  MiniTBPred reference;
  for (var i=0; i<preds.length; i++) {
    if (preds[i].name == "Admin") {
      reference = preds[i];
    }
  }
  var standings= {};
  for (int i=0; i<preds.length; i++) {
    if (preds[i].name != "Admin") {
      int totMalus = malus(preds[i], reference)[0] + malus(preds[i], reference)[1];
      standings[preds[i].name] = totMalus;
    }
  }
  var sortedKeys = standings.keys.toList(growable:false)
    ..sort((k1, k2) => standings[k1].compareTo(standings[k2]));
  LinkedHashMap sortedStandings = new LinkedHashMap
      .fromIterable(sortedKeys, key: (k) => k, value: (k) => standings[k]);
  var msg = sortedStandings.toString();
  msg = msg.substring(1, msg.length-1);
  msg = msg.replaceAll(", ", "\n");
  return msg;
}
