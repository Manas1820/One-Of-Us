// import 'package:Runbhumi/utils/Constants.dart';

import 'package:MAP/Constants.dart';
import 'package:MAP/Models/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future signInWithGoogle() async {
  await Firebase.initializeApp();
  //Initializing the Firebase auth Serivices
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  //Getting the device token of the device for FCM purposes;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    print('User is not null');
    //The user has authenticated already
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!result.exists) {
      //Creating a documnet
      Constants.prefs.setString("userId", user.uid);
      Constants.prefs.setString("profileImage", user.photoURL);
      Constants.prefs.setString("name", user.displayName);
      print('User Signed Up');
      //Writing to the backend and making a document for the user
      FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          UserProfile.newuser(user.uid, user.displayName, user.photoURL)
              .toJson());
    }
  }
}

Future<void> signOutGoogle() async {
  //Removing the device token, since the user is logging out
  await FirebaseAuth.instance.signOut();
  await googleSignIn.disconnect();
  Constants.prefs.setString('userId', null);
}

// Future saveToSharedPreference(String uid, String username, String displayName,
//     String photoURL, String emailId) async {
//   await Constants.saveName(displayName);
//   await Constants.saveProfileImage(photoURL);
//   await Constants.saveUserEmail(emailId);
//   await Constants.saveUserId(uid);
//   await Constants.saveUserName(username);
// }
