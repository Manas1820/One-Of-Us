import 'dart:async';
import 'package:MAP/Constants.dart';
import 'package:MAP/Screen/home.dart';
import 'package:MAP/Screen/oAuth.dart';
import 'package:MAP/onboarding.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Timer to change the screen in 2.2 seconds

  String _userId = Constants.prefs.getString('userId');
  String _firsttime = Constants.prefs.getString('firsttime');
  startTimeout() {
    return Timer(Duration(milliseconds: 4000), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    _firsttime == null
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => OnBoardingPage()))
        : _userId == null
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => GauthPage()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateRooms()));
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
      startTimeout();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/torn.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            // child: ScaleAnimatedTextKit(
            //   isRepeatingAnimation: true,
            //   onTap: () {
            //     print("Tap Event");
            //   },
            //   text: [
            //     "A.U.O.T.S.",
            //     "aka",
            //     "One Of Us",
            //   ],
            //   textStyle: TextStyle(
            //       fontSize: 70.0,
            //       fontFamily: "Nightmare",
            //     color: Colors.white
            //   ),
            //   textAlign: TextAlign.start,
            // ),
            child: TyperAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "A.U.O.T.S.",
                "aka",
                "One Of Us",
              ],

              // isRepeatingAnimation: false,
              textStyle: TextStyle(
                  fontSize: 75.0, fontFamily: "Nightmare", color: Colors.white),
              textAlign: TextAlign.start,
            ),
            // child: TypewriterAnimatedTextKit(
            //   onTap: () {
            //     print("Tap Event");
            //   },
            //   text: [
            //     "A.U.O.T.S.",
            //         "aka",
            //         "One Of Us",
            //   ],
            //   textStyle: TextStyle(
            //       fontSize: 50.0,
            //       fontFamily: "Nightmare"
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ),
        ) /* add child content here */,
      ),
    );
  }
}
