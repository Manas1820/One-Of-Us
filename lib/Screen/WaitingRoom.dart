import 'dart:async';

import 'package:MAP/Screen/SelectActivity.dart';
import 'package:MAP/Screen/SelectZone.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaitingRoom extends StatefulWidget {
  final String roomId;
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
  WaitingRoom({Key key, @required this.roomId}) : super(key: key);
}

class _WaitingRoomState extends State<WaitingRoom> {
  final db = FirebaseFirestore.instance;
  StreamSubscription sub;
  Map data;
  bool loading = false;
  Widget float1() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectZone(roomId: widget.roomId)));
        },
        tooltip: 'First button',
        child: Icon(Icons.map),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectActivity(roomId: widget.roomId)));
        },
        tooltip: 'Second button',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    sub = db.collection('games').doc(widget.roomId).snapshots().listen((snap) {
      setState(() {
        data = snap.data();
        loading = true;
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Container(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Waiting Area"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ListView.builder(
                          itemCount: data['playerName'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                data['playerName'][index].toString(),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ))
          : Container(child: Center(child: CircularProgressIndicator())),
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[float1(), float2()],
          colorStartAnimation: Colors.blueAccent,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }
}
