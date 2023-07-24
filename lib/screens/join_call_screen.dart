import 'package:flutter/material.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:vid_call/helper/colors.dart';
// import 'package:vid_call/helper/custom_btn.dart';
import 'package:vid_call/helper/custom_snackbar.dart';
// import 'package:vid_call/helper/join_meet_option.dart';
import 'package:vid_call/resources/auth_resources.dart';
import 'package:vid_call/resources/jisti_meet_res.dart';

class JoinClassRoom extends StatefulWidget {
  const JoinClassRoom({super.key});

  @override
  State<JoinClassRoom> createState() => _JoinClassRoomState();
}

class _JoinClassRoomState extends State<JoinClassRoom> {
  final AuthRes _authMethods = AuthRes();
  late TextEditingController meetingIdController = TextEditingController();
  late TextEditingController nameController;
  final JitsiMeetRes _jitsiMeetRes = JitsiMeetRes();
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    //Using initState for the name controller because we want to initialize the name with the nema eof the current user who has logged in initially and that we will be getting from the current user getter in the AuthRe() class , so in order to use this have to do that in init state
    nameController = TextEditingController(
      text: _authMethods.currUser.displayName,
    );
    super.initState();
  }

  //Disposing the controllers to avoid memory leaks
  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
  }

  //Method that will take a boolean parameter (which will be the currently changed value of the switch(toggle button))
  //and we will assign these values to the isAudioMuted and isVideoMuted properties , so that the UI could also change acordingly (thats why doing this in set state)
  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  //Method to join a meeting (pre existing)(The method is same as createMeeting one)
  joinExistingMeet() {
    _jitsiMeetRes.createMeeting(
      meetName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      context: context,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.symmetric(vertical: 38.0),
              child: Image.asset(
                'assets/images/joinVid.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    margin: const EdgeInsets.all(20),
                    child: TextField(
                      controller: meetingIdController,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.create_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: secondaryBackgroundColor,
                        filled: true,
                        hintText: 'Meet ID',
                        contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (meetingIdController.text.length != 8) {
                        showCustomSnackBar(
                            "The meeting room id should be 8 letters long",
                            context);
                      } else {
                        joinExistingMeet();
                      }
                    },
                    icon: const Icon(Icons.video_call),
                    label: const Text("Join"),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160, 60)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const Expanded(flex: 2, child: Text(""))
        ],
      ),
    );
  }
}
