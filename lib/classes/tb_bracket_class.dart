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
