import 'package:appbasce/classes/profile_class.dart';

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

double roundsMalus(Map<String,List<TBPred>> allPredictions, String name) {
  double malus = 0;
  for (var p in allPredictions.entries) {
    TBPred reference = namedPrediction(p.value, "Admin")!;
    TBPred? prediction = namedPrediction(p.value, name);
    if (prediction != null) {
      double thisMalus = ((reference.home - prediction.home).abs() + (reference.away - prediction.away).abs()) * multiplier[p.key]!;
      malus += thisMalus;
      if ((thisMalus == 0) && (reference.home+reference.away == 4)) {  // bonus sweep
        malus += -1;
      }
    }
  }
  return malus;
}
