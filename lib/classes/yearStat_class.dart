import 'package:appbasce/classes/profile_class.dart';

class Stats {
  String label;
  int year;
  List<Profile> first; // winner(s) of the tournament
  List<Profile> second; // second place
  List<Profile> third; // third place
  List<Profile> bracket; // winner(s) of the bracket
  List<Profile> rounds; // winner(s) of the 'rounds'
  List<String> profilePictures;

  Stats({this.label, this.year, this.first, this.second, this.third,
    this.bracket, this.rounds, this.profilePictures});
}

Stats i = Stats(label: 'I', year: 2016, first: [magu], second: [nic, teo], third: [],
    bracket: [magu], rounds: [nic], profilePictures: []);
Stats ii = Stats(label: 'II', year: 2017, first: [melo], second: [ale], third: [fabio],
    bracket: [ale, fabio, magu, melo], rounds: [melo], profilePictures: ['assets/profile2017.jpg']);
Stats iii = Stats(label: 'III', year: 2018, first: [ale], second: [magu], third: [melo],
    bracket: [ale, magu], rounds: [ale], profilePictures: ['assets/profile2018.jpg']);
Stats iv = Stats(label: 'IV', year: 2019, first: [melo], second: [luca], third: [enrico],
    bracket: [luca], rounds: [melo], profilePictures: ['assets/profile2019.jpg']);
Stats v = Stats(label: 'V', year: 2020, first: [teo], second: [ale], third: [magu],
    bracket: [teo, ale], rounds: [nic], profilePictures: ['assets/profile2020.jpg', 'assets/profile2020-bis.jpg']);
Stats vi = Stats(label: 'VI', year: 2021, first: [luca], second: [teo], third: [fabio],
    bracket: [fabio, melo], rounds: [teo], profilePictures: ['assets/profile2021.jpg']);

List<Stats> yearStats = [i, ii, iii, iv, v, vi];