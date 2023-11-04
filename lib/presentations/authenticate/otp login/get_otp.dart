import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/authenticate/get_otp_controller.dart';

import '../../../common widgets/button.dart';
import '../../../common widgets/text_field.dart';

class GetOtp extends StatefulWidget {
  const GetOtp({super.key});

  @override
  State<GetOtp> createState() => _GetOtpState();
}

class _GetOtpState extends State<GetOtp> {
  final getOtpForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetOtpController());
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
        SizedBox(
          height: size.height * 0.05,
        ),
        Form(
            key: getOtpForm,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MyTextField(
                controller: controller.phone,
                hintText: "Phone Number",
                fieldType: "Phone",
                inputType: TextInputType.phone,
                verticalPadding: 15,
                maxLength: 10,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                width: size.width,
                height: 50,
                child: MyElevatedButton(
                    onPress: () {
                      if (getOtpForm.currentState!.validate()) {
                        if (!controller.isLoading.value) {
                          GetOtpController.instance
                              .sendOttp(controller.phone.text.trim());
                        }
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
                              "GET OTP",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            );
                    })),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ]))
      ],
    );
  }
}
