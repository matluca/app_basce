import 'dart:collection';
import 'package:appbasce/classes/profile_class.dart';
import 'package:flutter/material.dart';

var allowedParticipants = {
  "Admin": admin,
  "Ale": ale,
  "Enrico": enrico,
  "Fabio": fabio,
  "Luca": luca,
  "Magu": magu,
  "Melo": melo,
  "Nic": nic,
  "Teo": teo,
  "Yiwei": yiwei
};

class TBPwd {
  final String name;
  final String pwd;

  TBPwd(this.name, this.pwd);
}

class TBPred {
  final String name;
  String homeTeam;
  String awayTeam;
  int home;
  int away;
  final DateTime? deadline;

  TBPred(this.name, this.homeTeam, this.awayTeam, this.home, this.away, this.deadline);
}

class TBPredId {
  final String id;
  final String name;

  TBPredId(this.id, this.name);
}

TBPred? namedPrediction(List<TBPred> pred, String name) {
  for (var p in pred) {
    if (p.name == name) {
      return p;
    }
  }
  return null;
}

Map<String,double> multiplier = {
  "E-2-1": 1,
  "E-2-2": 1,
  "W-2-1": 1,
  "W-2-2": 1,
  "E-3-1": 1.4,
  "W-3-1": 1.4,
  "F": 2,
};

Map<String,double> roundsMaluses(Map<String,List<TBPred>> allPredictions, List<TBPwd> pwds) {
  Map<String,double> maluses = {};
  for (var pwd in pwds) {
    if (pwd.name != 'Admin') {
      maluses[pwd.name] = roundsMalus(allPredictions, pwd.name);
    }
  }
  return maluses;
}

double roundsMalus(Map<String,List<TBPred>> allPredictions, String name) {
  double malus = 0;
  for (var p in allPredictions.entries) {
    TBPred reference = namedPrediction(p.value, "Admin")!;
    TBPred? prediction = namedPrediction(p.value, name);
    if (prediction != null) {
      double thisMalus = ((reference.home - prediction.home).abs() + (reference.away - prediction.away).abs()) * multiplier[p.key]!;
      malus += thisMalus;
      if ((thisMalus == 0) && (reference.home+reference.away == 4)) {  // bonus sweep
        malus += -0.5;
      }
    }
  }
  return malus;
}

Map<String,int> roundsStandings(Map<String,double> roundMaluses) {
  Map<String,int> standings = {};
  var sortedKeys = roundMaluses.keys.toList(growable: false)
    ..sort((k1, k2) => roundMaluses[k1]!.compareTo(roundMaluses[k2]!));
  for (int i = 0; i < sortedKeys.length; i++) {
    standings[sortedKeys[i]] = i+1;
    if ((i>0) && (roundMaluses[sortedKeys[i]] == roundMaluses[sortedKeys[i-1]])) {
      standings[sortedKeys[i]] = standings[sortedKeys[i-1]]!;
    }
  }
  return standings;
}
