// import 'package:Runbhumi/utils/Constants.dart';
// import 'package:Runbhumi/view/views.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // Constants.prefs.setString("firsttime", "done");
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => GauthPage()),
    // );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.png', width: 350.0),
      alignment: Alignment.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: "Nightmare2"),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      pageColor: Colors.black,
      imagePadding: EdgeInsets.only(top: 50),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Create or join a game",
          body:
          "Atmost 20 people can play in a game of 4 imposters and atmost 10 people in a game of 2.\n\n And then the game is on!",
          image: _buildImage("board1"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "If you are the IMPOSTER",
          body:
          "1. Fake your tasks. \n2. When you are in the vicinity of another player you will get a notif if you want to kill him/her. The accept option will send a notif on the players’ phone and he will be directed outside of the game circle.",
          image: _buildImage('board2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "If you are a PLAYER",
          body:
          "1. Complete your tasks. \n2.If you get kicked off the game, you again need to rush out of the game circle on the map. Once you are out, the others will get a notif that you weren’t the imposter.\n3. If you die by the imposter, you will get a notif that you are dead and you need to rush out of the playing circle on the map. You need to follow a dedicated path, that will appear on the screen and not talk to anyone on your way to tell them about the imposter or you will remove the fun of the game!",
          image: _buildImage('board3'),
          // footer: Button(
          //   myColor: Theme.of(context).primaryColor,
          //   onPressed: () {
          //     introKey.currentState?.animateScroll(0);
          //   },
          //   myText: "abcdefg",
          // ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tasks",
          body: "Number of Tasks \n=\nNumber of people playing\n\nThe tasks currently are standing in that place for a certain amount of time, but in the future we plan on giving you a small game to play during that time.",
          image: _buildImage('board4'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kick the suspect out of the game circle",
          body: "After someone is killed ",
          image: _buildImage('board5'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Who wins?",
          body:
          "IMPOSTERS win if even one of them survives till the end (the number of PLAYERS are less than or equal to the number of imposters).\n\nPLAYERS win if, They complete all of their tasks or they kick out all the imposters. ",
          image: _buildImage('board6'),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: Color(0xff2DADC2),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
