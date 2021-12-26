import 'package:appbasce/classes/profile_class.dart';

List<Profile> tbParticipants = [
  luca,
  admin
];

class TBPwd {
  final String name;
  final String pwd;

  TBPwd(this.name, this.pwd);
}

class TBPred {
  final String name;
  final String homeTeam;
  final String awayTeam;
  final int home;
  final int away;
  final DateTime deadline;

  TBPred(this.name, this.homeTeam, this.awayTeam, this.home, this.away, this.deadline);
}
