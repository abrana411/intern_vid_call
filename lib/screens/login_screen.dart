import 'package:flutter/material.dart';
// import 'package:vid_call/helper/colors.dart';
// import 'package:vid_call/helper/custom_btn.dart';
import 'package:vid_call/resources/auth_resources.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRes _authres = AuthRes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Meety',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset('assets/images/loginMain.png'),
          ),
          Align(
            child: Container(
              height: 60,
              width: 200,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  bool isSuccessfull = await _authres.signInWithGoogle(context);
                  if (isSuccessfull) {
                    if (context.mounted) {
                      Navigator.pushNamed(context, '/home_screen');
                    }
                  }
                },
                icon: Image.asset(
                  'assets/images/googleLogo.png',
                  height: 20,
                ),
                label: const Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  minimumSize: const Size(150, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
