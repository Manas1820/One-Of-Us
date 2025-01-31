import 'dart:ui';
import 'package:flutter/material.dart';
import 'oAuthPage.dart';

class GauthPage extends StatefulWidget {
  @override
  _GauthPageState createState() => _GauthPageState();
}

class _GauthPageState extends State<GauthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0, title: buildTitle(context, "Runbhumi")),
      // body: ConnectivityWidgetWrapper(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Image(
                image: AssetImage('images/images.jpg'),
              ),
            ),
            /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print("going to " + "/login");
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(800),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).primaryColor.withOpacity(.4),
                              blurRadius: 6,
                              offset: Offset(0, 5))
                        ]),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Button(
                myText: "SignUp",
                myColor: Theme.of(context).accentColor,
                routeName: "/signup",
              ),
              DividingOr(),*/
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: Text(
                " Connecting Games To Reality ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GoogleOauth(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
