import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else {
          //signed in go to shop page
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF31373D),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset('./images/logo.png'),
            SizedBox(
              width: 300.0,
              child: TextLiquidFill(
                text: 'UZCODING',
                loadDuration: const Duration(milliseconds: 2500),
                waveDuration: const Duration(milliseconds: 1250),
                waveColor: Colors.white,
                boxBackgroundColor: const Color(0xFF31373D),
                textStyle: const TextStyle(
                  fontSize: 56.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 150.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
