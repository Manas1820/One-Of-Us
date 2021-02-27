import 'package:cloud_firestore/cloud_firestore.dart';

class NewGame {
  GeoPoint center;
  double radius;
  String roomName;
  String roomId;
  List<GeoPoint> activity;

  NewGame(
      {this.center, this.radius, this.roomName, this.roomId, this.activity});

  NewGame.createNewGame(
      GeoPoint center, double radius, String roomName, String roomId) {
    this.center = center;
    this.radius = radius;
    this.roomName = roomName;
    this.roomId = roomId;
  }

  Map<String, dynamic> toJson() => {
        'center': this.center,
        'radius': this.radius,
        'roomName': this.roomName,
        'roomId': this.roomId,
      };

  factory NewGame.fromJson(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data();
    return NewGame(
        center: data['center'],
        radius: data['radius'],
        roomName: data['roomName'],
        roomId: data['roomId'],
        activity: data['activity']);
  }
}
