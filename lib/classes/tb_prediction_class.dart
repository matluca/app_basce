import 'package:appbasce/classes/profile_class.dart';

var allowedParticipants = {
  "Admin": admin,
  "Ale": ale,
  "Enrico": enrico,
  "Fabio": fabio,
  "Luca": luca,
  "Magu": magu,
  "Melo": melo,
  "Nic": nic,
  "Teo": teo,
  "Yiwei": yiwei
};

class TBPwd {
  final String name;
  final String pwd;

  TBPwd(this.name, this.pwd);
}

class TBPred {
  final String name;
  String homeTeam;
  String awayTeam;
  int home;
  int away;
  final DateTime? deadline;

  TBPred(this.name, this.homeTeam, this.awayTeam, this.home, this.away, this.deadline);
}

class TBPredId {
  final String id;
  final String name;

  TBPredId(this.id, this.name);
}
