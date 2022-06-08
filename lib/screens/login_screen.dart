import 'package:flutter/material.dart';
import '../widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF31373D),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 72, 78, 85),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    './images/logo.png',
                    color: Colors.white,
                    colorBlendMode: BlendMode.softLight,
                    width: 240,
                  ),
                  const Text(
                    'UZCODING',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: AuthUi(),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 15,
              left: 10,
              right: 10,
            ),
            child: Text(
              'Davom etish bilan Siz bizning\nShartlar va Qoidalarga rozisiz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
