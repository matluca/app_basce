import 'package:appbasce/classes/tb_prediction_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:base32/base32.dart';
import 'dart:async';

List<String> tbRoundsIds = [
  'E-2-1',
  'E-2-2',
  'W-2-1',
  'W-2-2',
  'E-3-1',
  'W-3-1',
  'F'
];

class DatabaseServiceTB {
  // collections reference
  final CollectionReference passwords =
      FirebaseFirestore.instance.collection('tb-passwords');
  final CollectionReference seeds =
      FirebaseFirestore.instance.collection('tb-seeds');
  final CollectionReference brackets =
      FirebaseFirestore.instance.collection('tb-brackets');
  final CollectionReference bracketDeadline =
      FirebaseFirestore.instance.collection('tb-bracket-deadline');

  // update predictions
  Future updatePredictions(
      String id, String name, int home, int away) async {
    Map<String, dynamic> data = {};
    data['home'] = home;
    data['away'] = away;
    data['name'] = name;
    CollectionReference coll = FirebaseFirestore.instance.collection(id);
    if (name == "Admin") {
      return await coll.doc(name).update(data);
    }
    return await coll.doc(name).set(data);
  }

  // update admin predictions
  Future updateAdminPredictions(
      String id, String name, String homeTeam, String awayTeam, int home, int away, DateTime deadline) async {
    Map<String, dynamic> data = {};
    data['home'] = home;
    data['home-team'] = homeTeam;
    data['away-team'] = awayTeam;
    data['away'] = away;
    data['deadline'] = deadline;
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

  // update bracket
  Future updateBracket(String name, Map<String,String> bracket) async {
    Map<String,dynamic> data = bracket;
    data['name'] = name;
    return await brackets.doc(name).set(data);
  }

  // get all predictions after deadline
  Future<Map<String,List<TBPred>>> get allPredictionsAfterDeadline async {
    Map<String,List<TBPred>> predictions = {};
    Map<String,List<TBPred>> allPreds = await allPredictions;
    for (var p in allPreds.entries) {
      TBPred reference = namedPrediction(p.value, "Admin")!;
      if ((reference.deadline == null) || (DateTime.now().isAfter(reference.deadline!))) {
        predictions[p.key] = p.value;
      }
    }
    return predictions;
  }

  // get all predictions
  Future<Map<String,List<TBPred>>> get allPredictions async {
    Map<String,List<TBPred>> predictions = {};
    for (var id in tbRoundsIds) {
      CollectionReference coll = FirebaseFirestore.instance.collection(id);
      List<TBPred> data = await coll.get().then(_predListFromSnapshot);
      predictions[id]=data;
    }
    return predictions;
  }

  // get predictions for a single series
  Stream<List<TBPred>> predictions(String id) {
    CollectionReference coll = FirebaseFirestore.instance.collection(id);
    return coll.snapshots().map(_predListFromSnapshot);
  }

  // predictions from snapshot
  List<TBPred> _predListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      String homeTeam = (doc.data() as Map)['home-team'] ?? "-";
      String awayTeam = (doc.data() as Map)['away-team'] ?? "-";
      int home = (doc.data() as Map)['home'] ?? 0;
      int away = (doc.data() as Map)['away'] ?? 0;
      DateTime? deadline;
      var timestamp = (doc.data() as Map)['deadline'];
      if (timestamp != null) {
        var dd = timestamp.toDate();
        deadline = DateTime.parse(dd.toString());
      }
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

  // get TB seeds
  Future<Map> get tbSeeds {
    return seeds.get().then(_tbSeedsFromSnapshot);
  }

  Map _tbSeedsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return (doc.data() as Map);
    }).toList()[0];
  }

  // get brackets
  Future<Map<String,Map<String,String>>> get tbBrackets async {
    Map<String,Map<String,String>> brs = {};
    List<Map> bracketList = await brackets.get().then(_tbBracketsFromSnapshot);
    for (var br in bracketList) {
      Map<String,String> b = {};
      String name = br['name'] ?? '';
      for (var entry in br.entries) {
        if (entry.key != 'name') {
          b[entry.key] = entry.value ?? '';
        }
      }
      brs[name] = b;
    }
    return brs;
  }

  List<Map> _tbBracketsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return (doc.data() as Map);
    }).toList();
  }

  // get deadline
  Future<DateTime> get bracketDdl {
    return bracketDeadline.get().then(_ddlFromSnapshot);
  }

  DateTime _ddlFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var timestamp = (doc.data() as Map)['deadline'];
      var dd = timestamp.toDate();
      return DateTime.parse(dd.toString());
    }).toList()[0];
  }
}
