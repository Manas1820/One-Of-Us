import 'package:flutter/material.dart';

class CreateRooms extends StatefulWidget {
  @override
  _CreateRoomsState createState() => _CreateRoomsState();
}

class _CreateRoomsState extends State<CreateRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: OutlineButton(
                onPressed: () {
                  print('Received click');
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
                onPressed: () {
                  print('Received click');
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
        onPressed: () {},
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
