import 'package:flutter/material.dart';
import 'package:vid_call/helper/colors.dart';

class JoinMeetOption extends StatelessWidget {
  final String text;
  final bool isOn;
  final Function(bool) onChange;
  const JoinMeetOption({
    Key? key,
    required this.text,
    required this.isOn,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //A simply container having a row to show:-
    //Text -> Switch(toggle button) which will have the value which we provide from the screen in which this is used which is join_call_screen screen
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          //whenever the user clicks on this switch the value assigned to it is Toggled , and the onChange method in the join_calll_screen will run taking that changed value and it will run the set state by changing the isAudioMuted and/or isVideoMuted variables accordingly
          Switch(
            value: isOn,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
