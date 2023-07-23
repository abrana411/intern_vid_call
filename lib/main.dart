import 'package:flutter/material.dart';
import 'package:vid_call/helper/colors.dart';
import 'package:vid_call/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vid Call',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),

      //Creating custom routes for easy navigation using pushNamed
      routes: {'/login_screen': (context) => const LoginScreen()},
      home: const LoginScreen(),
    );
  }
}
