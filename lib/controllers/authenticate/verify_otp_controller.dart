import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repo/authentication_repo.dart';

class VerifyOtpController extends GetxController {
  static VerifyOtpController get instance => Get.find();

  RxBool isLoading = false.obs;

  Future<void> verifyOtp(String number, String otp) async {
    isLoading(true);
    String? error = await AuthenticationRepo.instance.verifyOtp(number, otp);

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
