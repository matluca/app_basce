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
