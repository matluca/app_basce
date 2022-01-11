import 'package:appbasce/classes/tb_prediction_class.dart';

class TBBracketId {
  final String name;
  final Map<String,String> bracket;
  final DateTime deadline;

  TBBracketId(this.name, this.bracket, this.deadline);
}

Map<String,int> bracketToRoundsWon(Map<String,String> bracket, Map seeds) {
  Map<String,int> roundsWon = {};
  for (var team in seeds.values) {
    roundsWon[team] = 0;
  }
  for (var team in bracket.values) {
    roundsWon[team] = roundsWon[team]! + 1;
  }
  return roundsWon;
}

Map<String,int> noRoundsWon(Map seeds) {
  Map<String,int> roundsWon = {};
  for (var team in seeds.values) {
    roundsWon[team] = 0;
  }
  return roundsWon;
}

Map<String,int> bracketMaluses(Map<String, Map<String,int>> roundsWon, List<TBPwd> pwds, Map seeds) {
  Map<String,int> maluses = {};
  for (var pwd in pwds) {
    if (pwd.name != 'Admin') {
      maluses[pwd.name] = bracketMalus(roundsWon, pwd.name, seeds);
    }
  }
  return maluses;
}

int bracketMalus(Map<String, Map<String,int>> roundsWon, String name, Map seeds) {
  Map<String,int> reference = roundsWon['Admin']!;
  Map<String,int> bracket = roundsWon[name] ?? noRoundsWon(seeds);
  int malus = 0;
  for (var team in bracket.keys) {
    int diff = (bracket[team]! - reference[team]!).abs();
    if (diff == 1) {
      malus += 1;
    } else if (diff == 2) {
      malus += 3;
    } else if (diff == 3) {
      malus += 6;
    } else if (diff == 4) {
      malus += 10;
    }
  }
  return malus;
}

Map<String,int> bracketStandings(Map<String,int> bracketMaluses, Map<String,double> extra) {
  Map<String,double> tot = {};
  for (var entry in bracketMaluses.entries) {
    tot[entry.key] = entry.value + (extra[entry.key] ?? 0);
  }
  Map<String,int> standings = {};
  var sortedKeys = tot.keys.toList(growable: false)
    ..sort((k1, k2) => tot[k1]!.compareTo(tot[k2]!));
  for (int i = 0; i < sortedKeys.length; i++) {
    standings[sortedKeys[i]] = i+1;
    if ((i>0) && (tot[sortedKeys[i]] == tot[sortedKeys[i-1]])) {
      standings[sortedKeys[i]] = standings[sortedKeys[i-1]]!;
    }
  }
  return standings;
}
