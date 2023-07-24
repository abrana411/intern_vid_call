import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vid_call/resources/jisti_meet_res.dart';
import '../helper/meeting_btn.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetRes _jitsimeetRes = JitsiMeetRes();

  void createNewMeet(
      BuildContext context) //or create new meeting for the vid call
  {
    //Since creating a new meeting so have to give some random roonName/id ,
    var rand = Random();
    String roomId = (rand.nextInt(10000000) + 10000000)
        .toString(); // a 8 digit will be created like this
    _jitsimeetRes.createMeeting(
        meetName: roomId,
        isAudioMuted: true,
        isVideoMuted: true,
        context: context);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'Create or join a meet!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MeetingButton(
                onPressed: () {
                  createNewMeet(context);
                },
                text: 'New Meeting',
                icon: Icons.videocam,
              ),
              const SizedBox(
                width: 20,
              ),
              MeetingButton(
                onPressed: () {
                  //going to join clasRoom/meeting screen from here
                  joinMeeting(context);
                },
                text: 'Join Meeting',
                icon: Icons.add_box_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
