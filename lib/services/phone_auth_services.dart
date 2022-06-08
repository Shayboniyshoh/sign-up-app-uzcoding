// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_up_firebase_app/screens/home_screen.dart';

import '../screens/authentication/otp_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context, uid) async {
    final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();

    List<DocumentSnapshot> document = result.docs; // list of users data

    if (document.isNotEmpty) {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    } else {
      return users.doc(user!.uid).set({
        // if user data does not exist, add user data to firestore
        'uid': user!.uid, // user id
        'phoneNumber': user!.phoneNumber, // user phone number
        'email': user!.email, // user email
      }).then((value) {
        // after adding data to firestore then redirectes to home screen
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        // ignore: invalid_return_type_for_catch_error
      }).catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed = (FirebaseException e) {
      if (e.code == 'invalid-phone-number') {
        print('Provided phone number is invalid.');
      }
      print('The error is ${e.code}');
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent codeSent = (String verId, int? resendToken) async {
      // if OTP send, user should go to next screen to enter OTP code
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(
            number: number,
            verId: verId,
          ),
        ),
      );
    };
    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 90),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId);
          });
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
