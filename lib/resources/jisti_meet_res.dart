import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:vid_call/helper/custom_snackbar.dart';
import 'package:vid_call/resources/auth_resources.dart';
import 'package:vid_call/resources/firestore_resources.dart';

class JitsiMeetRes {
  //using below to get the current users name,email and photo url
  final AuthRes _authMethods = AuthRes();
  final FireStoreRes _fireStoreRes = FireStoreRes();

  //Below method will be used for creating a new meeting or joining an existing meeting
  Future<bool> createMeeting({
    required String meetName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username =
        '', //no compulsary (only needed when user is joining an existing meeting)
    required BuildContext context,
  }) async {
    bool isThereAMeeting = true;
    try {
      Map<String, Object> featureFlags = {};
      String name;

      //In case user wants to join a meeting (so the name might differ , so thats why checking if a name is provided in the function if yes then keep that else dont)
      if (username.isEmpty) {
        name = _authMethods.currUser.displayName!;
      } else {
        //Check here if there is a meeting with passed meet id or not (if yes only then we will join)
        isThereAMeeting = await _fireStoreRes.checkIfMeetExists(
            meetName: meetName, context: context);
        name = username;
      }
      if (!isThereAMeeting) {
        if (context.mounted) {
          showCustomSnackBar(
              "No Meeting Found With the Given Id/Name", context);
        }
        return false;
      }
      var options = JitsiMeetingOptions(
          roomNameOrUrl: meetName,
          userAvatarUrl: _authMethods.currUser.photoURL,
          isAudioMuted: isAudioMuted,
          isVideoMuted: isVideoMuted,
          userDisplayName: name,
          userEmail: _authMethods.currUser.email,
          featureFlags: featureFlags);

      //Adding this meet to the current users meetings history
      if (context.mounted) {
        if (username.isEmpty) //Creating New
        {
          _fireStoreRes.addToMeetingHistory(meetName,
              context: context, isNew: true);
        } else //Joining Existing
        {
          _fireStoreRes.addToMeetingHistory(meetName,
              context: context, isNew: false);
        }
      }
      //Now passing the options to join the meeting.
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      // print("error: $error");
      showCustomSnackBar(error.toString(), context);
    }
    return true;
  }
}
