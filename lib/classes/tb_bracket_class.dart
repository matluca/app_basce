class TBBracketId {
  final String name;
  final Map<String,String> bracket;

  TBBracketId(this.name, this.bracket);
}

Map<String,int> bracketToRoundsWon(Map<String,String> bracket, Map<String,String> seeds) {
  Map<String,int> roundsWon = {};
  for (var team in seeds.values) {
    roundsWon[team] = 0;
  }
  for (var team in bracket.values) {
    roundsWon[team] = roundsWon[team]! + 1;
  }
  return roundsWon;
}

