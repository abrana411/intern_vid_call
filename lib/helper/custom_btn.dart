import 'package:flutter/material.dart';
import 'package:vid_call/helper/colors.dart';

class MyCustomButton extends StatelessWidget {
  final String toShow;
  final VoidCallback onClick;
  const MyCustomButton(
      {super.key, required this.toShow, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: buttonColor),
          ),
        ),
        child: Text(
          toShow,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
