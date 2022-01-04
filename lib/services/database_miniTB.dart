import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:base32/base32.dart';

List<String> eastTeams = [
  'ATL',
  'BOS',
  'BRK',
  'CHI',
  'CHO',
  'CLE',
  'DET',
  'IND',
  'MIA',
  'MIL',
  'NYK',
  'ORL',
  'PHI',
  'TOR',
  'WAS'
];

List<String> westTeams = [
  'DAL',
  'DEN',
  'GSW',
  'HOU',
  'LAC',
  'LAL',
  'MEM',
  'MIN',
  'NOP',
  'OKC',
  'PHO',
  'POR',
  'SAC',
  'SAS',
  'UTA'
];

class DatabaseServiceMiniTB {
  // collections reference
  final CollectionReference predictions =
      FirebaseFirestore.instance.collection('predictions');
  final CollectionReference passwords =
      FirebaseFirestore.instance.collection('passwords');
  final CollectionReference deadline =
      FirebaseFirestore.instance.collection('deadline');

  // update predictions
  Future updatePredictionsFromOrderedList(
      String name, List<String> east, List<String> west) async {
    Map<String, dynamic> data = {};
    for (var i = 0; i < east.length; i++) {
      data[east[i]] = i + 1;
    }
    for (var i = 0; i < west.length; i++) {
      data[west[i]] = i + 1;
    }
    data['name'] = name;
    return await predictions.doc(name).set(data);
  }

  // update password
  Future updatePassword(String name, String pwd) async {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['pwd'] = base32.encodeString(pwd);
    return await passwords.doc(name).set(data);
  }

  // get predictions
  Stream<List<MiniTBPred>> get preds {
    return predictions.snapshots().map(_predListFromSnapshot);
  }

  // predictions from snapshot
  List<MiniTBPred> _predListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var eastPred = {};
      for (var team = 0; team < eastTeams.length; team++) {
        eastPred[eastTeams[team]] = (doc.data() as Map)[eastTeams[team]] ?? -1;
      }
      var westPred = {};
      for (var team = 0; team < westTeams.length; team++) {
        westPred[westTeams[team]] = (doc.data() as Map)[westTeams[team]] ?? -1;
      }

      return MiniTBPred((doc.data() as Map)['name'] ?? '', eastPred, westPred);
    }).toList();
  }

  // get passwords
  Stream<List<MiniTBPwd>> get pwds {
    return passwords.snapshots().map(_pwdsFromSnapshot);
  }

  List<MiniTBPwd> _pwdsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      if ((doc.data() as Map)['pwd'] == '') {
        return MiniTBPwd((doc.data() as Map)['name'] ?? '', '');
      }
      return MiniTBPwd(
        (doc.data() as Map)['name'] ?? '',
        base32.decodeAsString((doc.data() as Map)['pwd']),
      );
    }).toList();
  }

  // get deadline
  Stream<DateTime> get ddl {
    return deadline.snapshots().map(_ddlFromSnapshot);
  }

  DateTime _ddlFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var timestamp = (doc.data() as Map)['deadline'];
      var dd = timestamp.toDate();
      return DateTime.parse(dd.toString());
    }).toList()[0];
  }
}
