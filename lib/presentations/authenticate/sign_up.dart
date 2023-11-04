import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/authenticate/signup_controller.dart';

import '../../common widgets/button.dart';
import '../../common widgets/text_field.dart';
import '../../utils/color_theme.dart';
import 'widgets/continue_with_phone_btn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signupFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 23,
                )),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Form(
            key: signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                  child: Text(
                    "Let’s Start",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w600,
                        color: ColorTheme.primaryColor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                MyTextField(
                  controller: controller.email,
                  hintText: "Email Address",
                  fieldType: "Email",
                  inputType: TextInputType.emailAddress,
                  verticalPadding: 15,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                MyTextField(
                  controller: controller.password,
                  hintText: "Password",
                  fieldType: "Password",
                  verticalPadding: 15,
                  isObscure: true,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  width: size.width,
                  height: 50,
                  child: MyElevatedButton(
                      onPress: () {
                        if (signupFormKey.currentState!.validate()) {
                          if (!controller.isLoading.value) {
                            SignUpController.instance.registerUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
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
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              );
                      })),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const ContinueWithPhoneBtn()
        ],
      ),
    );
  }
}
