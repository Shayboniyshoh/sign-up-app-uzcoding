import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'You successfully signed in!',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then(
                      (value) => {
                        Navigator.pushReplacementNamed(context, LoginScreen.id),
                      },
                    );
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
