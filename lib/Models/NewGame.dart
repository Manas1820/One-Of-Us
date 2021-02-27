import 'package:MAP/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewGame {
  GeoPoint center;
  double radius;
  String roomName;
  String roomId;
  List<GeoPoint> activity;
  String leader;
  List playersName;
  List playersId;
  int max;

  NewGame(
      {this.center,
      this.radius,
      this.roomName,
      this.roomId,
      this.activity,
      this.leader,
      this.playersName,
      this.playersId,
      this.max});

  NewGame.createNewGame(
      GeoPoint center, double radius, String roomName, String roomId, int max) {
    this.center = center;
    this.radius = radius;
    this.roomName = roomName;
    this.roomId = roomId;
    this.leader = Constants.prefs.getString('userId');
    this.playersId = [Constants.prefs.getString('name')];
    this.playersName = [Constants.prefs.getString('userId')];
    this.max = max;
  }

  Map<String, dynamic> toJson() => {
        'center': this.center,
        'radius': this.radius,
        'roomName': this.roomName,
        'roomId': this.roomId,
        'leader': this.leader,
        'playerId': this.playersId,
        'playerName': this.playersName,
        'max': this.max
      };

  factory NewGame.fromJson(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data();
    return NewGame(
        center: data['center'],
        radius: data['radius'],
        roomName: data['roomName'],
        roomId: data['roomId'],
        activity: data['activity'],
        leader: data['leader'],
        playersId: data['playerId'],
        playersName: data['playerName'],
        max: data['max']);
  }
}
