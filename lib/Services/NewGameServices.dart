import 'package:MAP/Constants.dart';
import 'package:MAP/Models/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewGameServices {
  createGame(roomName) {
    var doc = FirebaseFirestore.instance.collection('games').doc();
    String id = Constants.prefs.getString('userId');
    String name = Constants.prefs.getString('name');
    doc.set({
      'roomName': 'alibaba',
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
      'payersName': FieldValue.arrayUnion([name]),
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
