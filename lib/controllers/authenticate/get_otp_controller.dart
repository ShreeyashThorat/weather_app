import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repo/authentication_repo.dart';

class GetOtpController extends GetxController {
  static GetOtpController get instance => Get.find();

  final phone = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> sendOttp(String number) async {
    isLoading(true);
    String? error = await AuthenticationRepo.instance.sendOtp(number);

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
