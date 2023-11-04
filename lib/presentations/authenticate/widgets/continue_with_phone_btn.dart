import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common widgets/button.dart';
import '../otp login/get_otp.dart';

class ContinueWithPhoneBtn extends StatefulWidget {
  const ContinueWithPhoneBtn({super.key});

  @override
  State<ContinueWithPhoneBtn> createState() => _ContinueWithPhoneBtnState();
}

class _ContinueWithPhoneBtnState extends State<ContinueWithPhoneBtn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(
                child: Divider(
              height: 1,
              color: Colors.grey,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text("OR"),
            ),
            const Expanded(child: Divider(height: 1, color: Colors.grey)),
          ],
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        SizedBox(
          width: size.width,
          height: 50,
          child: MyElevatedButton(
              onPress: () {
                Get.bottomSheet(
                  barrierColor: Colors.black.withOpacity(0.5),
                  isDismissible: false,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  enableDrag: false,
                  const GetOtp(),
                );
              },
              elevation: 0,
              buttonColor: Colors.transparent,
              borderSide: const BorderSide(color: Colors.black, width: 1),
              buttonContent: const Text(
                "Continue with phone",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              )),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
      ],
    );
  }
}
