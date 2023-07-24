import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vid_call/helper/custom_snackbar.dart';
import 'package:vid_call/resources/auth_resources.dart';

class FireStoreRes {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthRes _authRes = AuthRes();

  //Stream to keep track of the documents in the meetings collection of current user , such that if a new meeting is joined or created the history will be saved there
  Stream<QuerySnapshot<Map<String, dynamic>>> get pastMeetings => _firestore
      .collection('users')
      .doc(_authRes.currUser.uid)
      .collection('meetings')
      .snapshots();

  void addToMeetingHistory(String meetingName,
      {required BuildContext context, required bool isNew}) async {
    //So creating a new collectiuon if not there else if there then adding a document having meetingName and the time of creation of the meeting (whenever user creates one)
    try {
      await _firestore
          .collection('users')
          .doc(_authRes.currUser.uid)
          .collection('meetings')
          .add(isNew
              ? {
                  'meetName': meetingName,
                  'createdAt': DateTime.now(),
                  'joinedAt': "Null"
                }
              : {
                  'meetName': meetingName,
                  'joinedAt': DateTime.now(),
                  'createdAt': "Null"
                });
    } on FirebaseException catch (error) {
      showCustomSnackBar(error.message!, context);
    }
  }

  Future<bool> checkIfMeetExists(
      {required String meetName, required BuildContext context}) async {
    try {
      // Reference to the users collection
      final usersRef = FirebaseFirestore.instance.collection('users');

      // Query all users
      final querySnapshot = await usersRef.get();

      if (querySnapshot.size == 0) {
        return false;
      }

      // Loop through all users
      for (final userDoc in querySnapshot.docs) {
        final userID = userDoc
            .id; // Reference to the meetings subcollection of the current user
        final meetingsRef = usersRef.doc(userID).collection('meetings');

        // Query to search for meetings with the given meetName
        final meetingsQuerySnapshot =
            await meetingsRef.where('meetName', isEqualTo: meetName).get();

        if (meetingsQuerySnapshot.size == 0) {
          return false;
        }
      }
    } on FirebaseException catch (e) {
      // print(e);
      showCustomSnackBar(e.message!, context);
    }
    return true;
  }
}
