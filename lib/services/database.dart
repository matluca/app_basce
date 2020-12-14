import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:base32/base32.dart';

List<String> eastTeams = 
['ATL', 'BOS', 'BRK', 'CHI', 'CHO', 'CLE', 'DET', 'IND', 'MIA', 'MIL', 'NYK', 'ORL', 'PHI', 'TOR', 'WAS'];
List<String> westTeams = 
['DAL', 'DEN', 'GSW', 'HOU', 'LAC', 'LAL', 'MEM', 'MIN', 'NOP', 'OKC', 'PHO', 'POR', 'SAC', 'SAS', 'UTA'];

class DatabaseService {

  // collections reference
  final CollectionReference predictions = Firestore.instance.collection('predictions');
  final CollectionReference passwords = Firestore.instance.collection('passwords');
  final CollectionReference deadline = Firestore.instance.collection('deadline');

  // update predictions
  Future updatePredictionsFromOrderedList(String name, List<String> east, List<String> west) async {
    Map<String, dynamic> data = {};
    for (var i=0; i<east.length; i++) {
      data[east[i]] = i+1;
    }
    for (var i=0; i<west.length; i++) {
      data[west[i]] = i+1;
    }
    data['name'] = name;
    return await predictions.document(name).setData(data);
  }

  // update password
  Future updatePassword(String name, String pwd) async {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['pwd'] = base32.encodeString(pwd);
    return await passwords.document(name).setData(data);
  }

  // get predictions
  Stream<List<MiniTBPred>> get preds {
    return predictions.snapshots().map(_predListFromSnapshot);
  }

  // predictions from snapshot
  List<MiniTBPred> _predListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      var eastPred = {};
      for (var team=0; team <eastTeams.length; team++){
        eastPred[eastTeams[team]] = doc.data[eastTeams[team]] ?? -1;
      }
      var westPred = {};
      for (var team=0; team <westTeams.length; team++){
        westPred[westTeams[team]] = doc.data[westTeams[team]] ?? -1;
      }
      
      return MiniTBPred(
        name: doc.data['name'] ?? '',
        east: eastPred,
        west: westPred,
      );
    }).toList();
  }

  // get passwords
  Stream<List<MiniTBPwd>> get pwds {
    return passwords.snapshots().map(_pwdsFromSnapshot);
  }

  List<MiniTBPwd> _pwdsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      if (doc.data['pwd'] == '') {
        return MiniTBPwd(
          name: doc.data['name'] ?? '',
          pwd: '',
        );
      }
      return MiniTBPwd(
        name: doc.data['name'] ?? '',
        pwd: base32.decodeAsString(doc.data['pwd']),
      );
    }).toList();
  }

  // get passwords
  Stream<DateTime> get ddl {
    return deadline.snapshots().map(_ddlFromSnapshot);
  }

  DateTime _ddlFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      var timestamp = doc.data['deadline'];
      var dd = timestamp.toDate();
      return DateTime.parse(dd.toString());
    }).toList()[0];
  }
}
