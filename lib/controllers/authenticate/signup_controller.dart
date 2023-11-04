import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repo/authentication_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> registerUser(String email, String password) async {
    isLoading(true);
    String? error = await AuthenticationRepo.instance
        .createUserWithEmailAndPassword(email, password);

    if (error != null) {
      isLoading(false);
      Get.showSnackbar(GetSnackBar(
        message: error,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        margin: const EdgeInsets.all(10.0),
        borderRadius: 10,
        backgroundColor: Colors.grey.shade400,
        forwardAnimationCurve: Curves.easeOutCirc,
        reverseAnimationCurve: Curves.easeOutCirc,
      ));
    }
  }
}
