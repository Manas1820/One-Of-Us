import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
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
                  fontSize: 75.0,
                  fontFamily: "Nightmare",
                  color: Colors.white
              ),
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
