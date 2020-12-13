import 'package:appbasce/classes/profile_class.dart';

DateTime deadline = DateTime.parse("2021-07-20 20:18:04Z");
bool deadlineOn = false;
List<Profile> miniTBParticipants = [ale, enrico, fabio, luca, magu, melo, nic, teo, admin];

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
  List<String> p = new List(15);
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

int malus(MiniTBPred prediction, MiniTBPred reference) {
  int m = 0;
  prediction.east.keys.forEach((team) {
    m = m + (prediction.east[team] - reference.east[team]).abs();
  });
  prediction.west.keys.forEach((team) {
    m = m + (prediction.west[team] - reference.west[team]).abs();
  });
  return m;
}
