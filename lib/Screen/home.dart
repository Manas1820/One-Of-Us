import 'package:MAP/Constants.dart';
import 'package:MAP/Screen/WaitingRoom.dart';
import 'package:MAP/Services/NewGameServices.dart';
import 'package:MAP/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateRooms extends StatefulWidget {
  @override
  _CreateRoomsState createState() => _CreateRoomsState();
}

class _CreateRoomsState extends State<CreateRooms> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: mycontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white,
                  labelText: 'Enter the Game Code',
                  hintText: 'Faree',
                  hintStyle: TextStyle(
                    color: Colors.purple,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: OutlineButton(
                onPressed: () async {
                  var doc =
                      FirebaseFirestore.instance.collection('games').doc();
                  String id = Constants.prefs.getString('userId');
                  String name = Constants.prefs.getString('name');
                  doc.set({
                    'roomName': mycontroller.text.toString(),
                    'roomId': doc.id,
                    'leader': Constants.prefs.getString('userId'),
                    'playerId': FieldValue.arrayUnion([id]),
                    'playerName': FieldValue.arrayUnion([name]),
                    'max': 10
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WaitingRoom(roomId: doc.id)));
                },
                child: Text(
                  'Create a Game',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nightmare",
                      fontSize: 60.0),
                ),
                // borderSide: BorderSide(color: Colors.white, width: 1),
                splashColor: Colors.red,
                highlightedBorderColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: OutlineButton(
                onPressed: () async {
                  if (FirebaseFirestore.instance
                          .collection('games')
                          .doc(Text(mycontroller.text).toString()) !=
                      null)
                    await NewGameServices()
                        .joinGame(mycontroller.text.toString());

                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WaitingRoom(
                              roomId: mycontroller.text.toString())));
                },
                child: Text(
                  'Join a Game',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nightmare",
                      fontSize: 60.0),
                ),
                splashColor: Colors.red,
                highlightedBorderColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => OnBoardingPage()));
        },
        label: Text(
          'Rules',
          style: TextStyle(
              color: Colors.black, fontFamily: "Nightmare", fontSize: 40.0),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
