import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:base32/base32.dart';

List<String> ids = [
  'E-1-1',
  'E-1-2',
  'E-1-3',
  'E-1-4',
  'E-2-1',
  'E-2-2',
  'E-3-1',
  'W-1-1',
  'W-1-2',
  'W-1-3',
  'W-1-4',
  'W-2-1',
  'W-2-2',
  'W-3-1',
  'F'
];

class DatabaseServiceTB {
  // collections reference
  final CollectionReference passwords =
      FirebaseFirestore.instance.collection('tb-passwords');

  // update predictions
  Future updatePredictions(
      String id, String name, int home, int away) async {
    Map<String, dynamic> data = {};
    data['home'] = home;
    data['away'] = away;
    data['name'] = name;
    CollectionReference coll = FirebaseFirestore.instance.collection(id);
    return await coll.doc(name).set(data);
  }

  // update password
  Future updatePassword(String name, String pwd) async {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['pwd'] = base32.encodeString(pwd);
    return await passwords.doc(name).set(data);
  }

  // get predictions
  Stream<List<TBPred>> predictions(String id) {
    CollectionReference coll = FirebaseFirestore.instance.collection(id);
    return coll.snapshots().map(_predListFromSnapshot);
  }

  // predictions from snapshot
  List<TBPred> _predListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      String homeTeam = (doc.data() as Map)['home-team'];
      String awayTeam = (doc.data() as Map)['away-team'];
      int home = (doc.data() as Map)['home'];
      int away = (doc.data() as Map)['away'];
      var timestamp = (doc.data() as Map)['deadline'];
      var dd = timestamp.toDate();
      DateTime deadline = DateTime.parse(dd.toString());
      String name = (doc.data() as Map)['name'];
      return TBPred(name, homeTeam, awayTeam, home, away, deadline);
    }).toList();
  }

  // get passwords
  Stream<List<TBPwd>> get pwds {
    return passwords.snapshots().map(_pwdsFromSnapshot);
  }

  List<TBPwd> _pwdsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      if ((doc.data() as Map)['pwd'] == '') {
        return TBPwd((doc.data() as Map)['name'] ?? '', '');
      }
      return TBPwd(
        (doc.data() as Map)['name'] ?? '',
        base32.decodeAsString((doc.data() as Map)['pwd']),
      );
    }).toList();
  }
}