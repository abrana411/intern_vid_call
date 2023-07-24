import 'package:flutter/material.dart';
// import 'package:vid_call/helper/colors.dart';

// A custom button having the void call back m the text to show , the icon , based on the button (ie will pass this from whereever this will be used)
class MeetingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  const MeetingButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ThemeData().primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.white.withOpacity(0.1),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: 120,
            height: 60,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
