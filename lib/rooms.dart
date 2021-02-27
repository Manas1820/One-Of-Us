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
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        label: Text('Rules'),
        backgroundColor: Colors.red,
      ),

    );
  }
}

