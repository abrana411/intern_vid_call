import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vid_call/helper/custom_snackbar.dart';

class AuthRes {
  //getting the instance of firebase auth (for authenticating the user with the credential we get after the google sign in)
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //and the instance of the firestore as weel , to store the new users (name , profile pic url and the user id) in the data base as well
  //so that we can also see which use is using the application
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //creating a user stream (which will change of the auth state of the user changes) and we will pass this to the stream builder in the main.dart file
  Stream<User?> get isAuthStateChanged => _auth
      .authStateChanges(); //this authStateChanges returns a stream having the current User (so if a new user logeed in or logged out then all those state changes will come here and we are passing this to the stream builder in the main.dart for the real time updation of the app)

  //getter to get the current user:-
  User get currUser => _auth.currentUser!;
  //function that will be returning true(if the authentication was successfull) and false(else)
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      //Sign in the user
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //authenticate and get the user credential
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //sign in with the credential to the firebase as well
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      //get the user and check if the user is not null ie successfully got the user , then simply check if the user is new
      //if it is then add the details to the firstore (collection->users and the doc with teh id created after sign in , and set the username , uid and the profile pic, which we get from the google account of the user )
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true; //successfull sign in
      }
    } on FirebaseAuthException catch (e) {
      //showing the firebase auth error message for better error message
      showCustomSnackBar(e.message!, context);
      // res = false; // no need as by default false initially when creating the variable res above
    }
    return res;
  }

  //Sign out method:-
  void signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();

      //Since the user state will change so it will automatically be back onto the login screen
    } on FirebaseAuthException catch (e) {
      // showCustomSnackBar(e.message!, context);
      print(e.message!);
    }
  }
}
