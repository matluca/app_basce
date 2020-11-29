import 'package:appbasce/classes/miniTB_prediction_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> eastTeams = 
['ATL', 'BOS', 'BRK', 'CHI', 'CHO', 'CLE', 'DET', 'IND', 'MIA', 'MIL', 'NYK', 'ORL', 'PHI', 'TOR', 'WAS'];
List<String> westTeams = 
['DAL', 'DEN', 'GSW', 'HOU', 'LAC', 'LAL', 'MEM', 'MIN', 'NOP', 'OKC', 'PHO', 'POR', 'SAC', 'SAS', 'UTA'];

class DatabaseService {

  // collections reference
  final CollectionReference predictions = Firestore.instance.collection('predictions');

  // update predictions
  Future updatePredictions(String name, List<int> east, List<int> west) async {
    return await predictions.document(name).setData({
      'name': name,
      'ATL': east[0],
      'BOS': east[1],
      'BRK': east[2],
      'CHI': east[3],
      'CHO': east[4],
      'CLE': east[5],
      'DET': east[6],
      'IND': east[7],
      'MIA': east[8],
      'MIL': east[9],
      'NYK': east[10],
      'ORL': east[11],
      'PHI': east[12],
      'TOR': east[13],
      'WAS': east[14],
      'DAL': west[0],
      'DEN': west[1],
      'GSW': west[2],
      'HOU': west[3],
      'LAC': west[4],
      'LAL': west[5],
      'MEM': west[6],
      'MIN': west[7],
      'NOP': west[8],
      'OKC': west[9],
      'PHO': west[10],
      'POR': west[11],
      'SAC': west[12],
      'SAS': west[13],
      'UTA': west[14],
    });
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
}


// https://www.youtube.com/watch?v=TKM6_MTNGsI&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=20