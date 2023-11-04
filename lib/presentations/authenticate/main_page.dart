import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/constant_text.dart';

import '../../common widgets/button.dart';
import '../../utils/constant_images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: size.width * 0.075),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(ConstantImages.mainPage))),
          )),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                  child: const Text(
                    ConstantText.introLine,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 50,
                        child: MyElevatedButton(
                            onPress: () => Get.toNamed('/login'),
                            elevation: 0,
                            buttonContent: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      )),
                      Expanded(
                          child: SizedBox(
                        height: 50,
                        child: MyElevatedButton(
                            onPress: () => Get.toNamed('/signup'),
                            elevation: 0,
                            buttonColor: Colors.transparent,
                            buttonContent: const Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
