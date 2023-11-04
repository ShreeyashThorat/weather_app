import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentations/authenticate/otp login/verify_otp.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  String verifyId = "";

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null ? Get.offAllNamed('/mainpage') : Get.offAllNamed('/home');
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      firebaseUser.value != null
          ? Get.offAllNamed('/home')
          : Get.offAllNamed('/mainpage');
      return "$email Successfully Registered";
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        log(e.toString());
        return "Something went wrong!";
      }
    } catch (e) {
      log(e.toString());
      return "Something went wrong!";
    }
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Successfully Logged In";
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return "Invalid email or password";
    } catch (e) {
      log(e.toString());
      return "Something went wrong!";
    }
  }

  Future<String?> sendOtp(String number) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Get.showSnackbar(GetSnackBar(
            message: "Wrong Otp",
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            margin: const EdgeInsets.all(10.0),
            borderRadius: 10,
            backgroundColor: Colors.grey.shade400,
            forwardAnimationCurve: Curves.easeOutCirc,
            reverseAnimationCurve: Curves.easeOutCirc,
          ));
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          Get.back();
          Get.bottomSheet(
            barrierColor: Colors.black.withOpacity(0.5),
            isDismissible: false,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            enableDrag: false,
            VerifyOtp(
              number: number,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log(e.toString());
      return "Failed to send otp";
    }
    return null;
  }

  Future<String?> verifyOtp(String number, String otp) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
      return "Successfully Logged In";
    } catch (e) {
      log(e.toString());
      return "Failed to verify otp";
    }
  }
}
