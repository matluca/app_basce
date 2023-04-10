import 'package:appbasce/classes/profile_class.dart';

class MiniTBStats {
  String label;
  String season;
  List<Profile> first; // winner(s) of the tournament
  List<Profile> second; // second place
  List<Profile> third; // third place

  MiniTBStats(this.label, this.season, this.first, this.second, this.third);
}

MiniTBStats iMini = MiniTBStats('I', "2020-21", [luca], [ale], [nic]);
MiniTBStats iiMini = MiniTBStats('II', "2021-22", [magu], [luca], [ale]);
MiniTBStats iiiMini = MiniTBStats('III', "2022-23", [luca], [ale], [nic]);

List<MiniTBStats> miniTBStats = [iMini, iiMini, iiiMini];
