import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:weather_app/controllers/authenticate/verify_otp_controller.dart';

import '../../../common widgets/button.dart';
import '../../../utils/color_theme.dart';

class VerifyOtp extends StatefulWidget {
  final String number;
  const VerifyOtp({super.key, required this.number});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  bool showVerifyBtn = false;
  String otp = '';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyOtpController());
    Size size = MediaQuery.of(context).size;
    return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 23,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "OTP sent on +91-${widget.number}",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: ColorTheme.primaryColor),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Enter 6 digit OTP",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              height: size.width * 0.13,
              width: size.width * 0.8,
              child: PinFieldAutoFill(
                autoFocus: true,
                currentCode: otp,
                codeLength: 6,
                cursor: Cursor(
                    color: Colors.black, height: 18, width: 1, enabled: true),
                decoration: BoxLooseDecoration(
                  gapSpace: 8,
                  radius: const Radius.circular(6),
                  bgColorBuilder:
                      PinListenColorBuilder(Colors.white, Colors.white),
                  strokeColorBuilder: PinListenColorBuilder(
                    const Color(0xff586266),
                    const Color(0xff586266),
                  ),
                  strokeWidth: 1,
                ),
                onCodeChanged: (otp_) async {
                  otp = otp_!;
                  if (otp_.length == 6) {
                    setState(() {
                      showVerifyBtn = true;
                    });
                  } else {
                    setState(() {
                      showVerifyBtn = false;
                    });
                  }
                },
                onCodeSubmitted: (otp) async {},
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          showVerifyBtn == true
              ? SizedBox(
                  width: size.width,
                  height: 50,
                  child: MyElevatedButton(
                      onPress: () {
                        if (!controller.isLoading.value) {
                          VerifyOtpController.instance
                              .verifyOtp(widget.number, otp);
                        }
                      },
                      elevation: 0,
                      buttonContent: Obx(() {
                        return controller.isLoading.value
                            ? const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 25,
                                duration: Duration(seconds: 2),
                              )
                            : const Text(
                                "VERIFY OTP",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              );
                      })),
                )
              : const SizedBox(),
          SizedBox(
            height: size.height * 0.05,
          ),
        ]);
  }
}
