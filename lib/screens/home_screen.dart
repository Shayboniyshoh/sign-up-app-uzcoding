import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'You successfully signed in!',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
