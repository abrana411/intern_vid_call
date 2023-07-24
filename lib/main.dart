import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vid_call/helper/colors.dart';
import 'package:vid_call/resources/auth_resources.dart';
import 'package:vid_call/screens/home_screen.dart';
import 'package:vid_call/screens/join_call_screen.dart';
import 'package:vid_call/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vid Call',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),

      //Creating custom routes for easy navigation using pushNamed
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/video-call': (context) => const JoinClassRoom()
      },
      // home: const LoginScreen(), //Instead of showing the login screen directly we will listen the user auth changes and if the auth status of the user changes then we will do the navigation based on it (For the state persistence)
      home: StreamBuilder(
        //listening to the stream created in the AuthRes class
        stream: AuthRes().isAuthStateChanged,
        builder: (context, snapshot) {
          //if no snapshot (user) is received yet so show progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //if some user is signed in then show the user.
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          //else to login screen (if no use is signed in)
          return const LoginScreen();
        },
      ),
    );
  }
}
