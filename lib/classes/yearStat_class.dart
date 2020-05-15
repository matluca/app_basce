import 'package:appbasce/classes/profile_class.dart';

class Stats {
  String label;
  int year;
  List<Profile> first; // winner(s) of the tournament
  List<Profile> second; // second place
  List<Profile> third; // third place
  List<Profile> bracket; // winner(s) of the bracket
  List<Profile> rounds; // winner(s) of the 'rounds'

  Stats({this.label, this.year, this.first, this.second, this.third,
    this.bracket, this.rounds});
}

Stats i = Stats(label: 'I', year: 2016, first: [magu], second: [nic, teo], third: [],
    bracket: [magu], rounds: [nic]);
Stats ii = Stats(label: 'II', year: 2017, first: [melo], second: [ale], third: [fabio],
    bracket: [ale, fabio, magu, melo], rounds: [melo]);
Stats iii = Stats(label: 'III', year: 2018, first: [ale], second: [magu], third: [melo],
    bracket: [ale, magu], rounds: [ale]);
Stats iv = Stats(label: 'IV', year: 2019, first: [melo], second: [luca], third: [enrico],
    bracket: [luca], rounds: [melo]);

List<Stats> yearStats = [i, ii, iii, iv];