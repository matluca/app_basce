import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  //collections reference
  final CollectionReference eastPredictions = Firestore.instance.collection('east-predictions');
  final CollectionReference westPredictions = Firestore.instance.collection('west-predictions');

  Future updateEast(String name, List<int> predictions) async {
    print("updating east");
    return await eastPredictions.document(name).setData({
      'ATL': predictions[0],
      'BOS': predictions[1],
      'BRK': predictions[2],
      'CHI': predictions[3],
      'CHO': predictions[4],
      'CLE': predictions[5],
      'DET': predictions[6],
      'IND': predictions[7],
      'MIA': predictions[8],
      'MIL': predictions[9],
      'NYK': predictions[10],
      'ORL': predictions[11],
      'PHI': predictions[12],
      'TOR': predictions[13],
      'WAS': predictions[14],
    });
  }
  Future updateWest(String name, List<int> predictions) async {
    return await eastPredictions.document(name).setData({
      'DAL': predictions[0],
      'DEN': predictions[1],
      'GSW': predictions[2],
      'HOU': predictions[3],
      'LAC': predictions[4],
      'LAL': predictions[5],
      'MEM': predictions[6],
      'MIN': predictions[7],
      'NOP': predictions[8],
      'OKC': predictions[9],
      'PHO': predictions[10],
      'POR': predictions[11],
      'SAC': predictions[12],
      'SAS': predictions[13],
      'UTA': predictions[14],
    });
  }

}