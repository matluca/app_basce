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

  Stats(this.label, this.year, this.first, this.second, this.third,
      this.bracket, this.rounds, this.profilePictures);
}

Stats i = Stats('I', 2016, [magu], [nic, teo], [], [magu], [nic], []);
Stats ii = Stats('II', 2017, [melo], [ale], [fabio], [ale, fabio, magu, melo],
    [melo], ['assets/profile2017.jpg']);
Stats iii = Stats('III', 2018, [ale], [magu], [melo], [ale, magu], [ale],
    ['assets/profile2018.jpg']);
Stats iv = Stats('IV', 2019, [melo], [luca], [enrico], [luca], [melo],
    ['assets/profile2019.jpg']);
Stats v = Stats('V', 2020, [teo], [ale], [magu], [teo, ale], [nic],
    ['assets/profile2020.jpg', 'assets/profile2020-bis.jpg']);
Stats vi = Stats('VI', 2021, [luca], [teo], [fabio], [fabio, melo], [teo],
    ['assets/profile2021.jpg']);
Stats vii = Stats('VII', 2022, [nic], [melo], [enrico], [nic], [melo],
    ['assets/profile2022.jpg']);
Stats viii = Stats('VIII', 2023, [teo], [enrico], [nic], [teo], [melo],
    ['assets/profile2023.png']);

List<Stats> yearStats = [i, ii, iii, iv, v, vi, vii, viii];
