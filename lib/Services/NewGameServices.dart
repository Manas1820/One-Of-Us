import 'package:MAP/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewGameServices {
  createGame(roomName) {
    var doc = FirebaseFirestore.instance.collection('games').doc();
    String id = Constants.prefs.getString('userId');
    String name = Constants.prefs.getString('name');
    doc.set({
      'roomName': roomName,
      'roomId': doc.id,
      'leader': Constants.prefs.getString('userId'),
      'playerId': FieldValue.arrayUnion([id]),
      'payersName': FieldValue.arrayUnion([name]),
      'max': 10
    });
  }

  joinGame(String gameId) {
    String id = Constants.prefs.getString('userId');
    String name = Constants.prefs.getString('name');
    FirebaseFirestore.instance.collection('games').doc(gameId).update({
      'playerId': FieldValue.arrayUnion([id]),
      'playerName': FieldValue.arrayUnion([name]),
    });
  }

  leaveGame(String gameId, String userId) {
    FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .collection('players')
        .doc(userId)
        .delete();
  }
}

catchPlayer(GeoPoint point1, GeoPoint point2) {
  if (point1 == point2) {
    return "Kill";
    //print("Kill");
  }
}
