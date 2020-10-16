import 'package:appbasce/classes/profile_class.dart';

class Stats {
  String label;
  int year;
  List<Profile> first; // winner(s) of the tournament
  List<Profile> second; // second place
  List<Profile> third; // third place
  List<Profile> bracket; // winner(s) of the bracket
  List<Profile> rounds; // winner(s) of the 'rounds'
  String profilePicture;

  Stats({this.label, this.year, this.first, this.second, this.third,
    this.bracket, this.rounds, this.profilePicture});
}

Stats i = Stats(label: 'I', year: 2016, first: [magu], second: [nic, teo], third: [],
    bracket: [magu], rounds: [nic], profilePicture: '');
Stats ii = Stats(label: 'II', year: 2017, first: [melo], second: [ale], third: [fabio],
    bracket: [ale, fabio, magu, melo], rounds: [melo], profilePicture: 'assets/profile2017.jpg');
Stats iii = Stats(label: 'III', year: 2018, first: [ale], second: [magu], third: [melo],
    bracket: [ale, magu], rounds: [ale], profilePicture: 'assets/profile2018.jpg');
Stats iv = Stats(label: 'IV', year: 2019, first: [melo], second: [luca], third: [enrico],
    bracket: [luca], rounds: [melo], profilePicture: 'assets/profile2019.jpg');
Stats v = Stats(label: 'V', year: 2020, first: [teo], second: [ale], third: [magu],
    bracket: [teo, ale], rounds: [nic], profilePicture: 'assets/profile2020.jpg');

List<Stats> yearStats = [i, ii, iii, iv, v];