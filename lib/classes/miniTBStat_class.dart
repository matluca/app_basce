import 'package:appbasce/classes/profile_class.dart';

class MiniTBStats {
  String label;
  int year;
  List<Profile> first; // winner(s) of the tournament
  List<Profile> second; // second place
  List<Profile> third; // third place

  MiniTBStats({this.label, this.year, this.first, this.second, this.third});
}

MiniTBStats iMini = MiniTBStats(label: 'I', year: 2020, first: [luca], second: [ale], third: [nic]);

List<MiniTBStats> miniTBStats = [iMini];