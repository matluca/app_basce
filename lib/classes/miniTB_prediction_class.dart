class MiniTBPred {

  final String name;
  final Map east;
  final Map west;

  MiniTBPred({ this.name, this.east, this.west });

}

Map buildStandings(Map predictions) {
  var standings = {};
  for (int i=1; i<16; i++) {
    standings[i] = '';
  }
  predictions.forEach((key, value) { standings[value] = key; });
  return standings;
}