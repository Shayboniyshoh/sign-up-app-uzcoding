import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../screens/authentication/google_auth.dart';
import '../screens/authentication/phone_auth_screen.dart';
import '../services/phone_auth_services.dart';

class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 105, 115, 128),
                ),
                overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, PhoneAuthScreen.id);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.phone_android_outlined,
                  ),
                  SizedBox(width: 8),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Telefon bilan kirish',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SignInButtonBuilder(
            backgroundColor: const Color.fromARGB(255, 105, 115, 128),
            icon: Icons.email,
            text: ('Google bilan kirish'),
            fontSize: 16,
            highlightColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            onPressed: () async {
              User? user =
                  await GoogleAuthentication.signInWithGoogle(context: context);
              if (user != null) {
                PhoneAuthService auth = PhoneAuthService();
                // ignore: use_build_context_synchronously
                auth.addUser(context, user.uid);
              }
            },
          ),
          const SizedBox(height: 10),
          SignInButtonBuilder(
            backgroundColor: const Color.fromARGB(255, 105, 115, 128),
            icon: Icons.email_rounded,
            highlightColor: Colors.lightBlueAccent,
            text: ('Email bilan kirish'),
            fontSize: 16,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
