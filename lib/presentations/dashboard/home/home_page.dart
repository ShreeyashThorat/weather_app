import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weather_app/common%20widgets/text_field.dart';
import 'package:weather_app/presentations/dashboard/home/widgets/forecast_loading.dart';
import 'package:weather_app/utils/date_formatter.dart';

import '../../../common widgets/button.dart';
import '../../../controllers/forecast/forecast_controller.dart';
import 'widgets/this_week_forecast.dart';
import 'widgets/todays_forecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ForecastController forecastController = Get.put(ForecastController());
  @override
  void initState() {
    super.initState();
    if (!forecastController.currentLocationObtained.value) {
      forecastController.fetchCurrentLocationWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              children: [
                Expanded(
                    child: MyTextField(
                  controller: forecastController.searchLocation,
                  hintText: "Search City",
                  fieldType: "Search City",
                  radius: 10,
                  verticalPadding: 12,
                  suffix: IconButton(
                      onPressed: () {
                        if (forecastController.isLoading.value == false) {
                          FocusScope.of(context).unfocus();
                          forecastController.fetchWeatherByLocation(
                              forecastController.searchLocation.text);
                        }
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                )),
                SizedBox(
                  width: size.width * 0.045,
                ),
                InkWell(
                  onTap: () {
                    logoutBox(context);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: Colors.black45,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            if (forecastController.isLoading.value) {
              return const ForeCastLoading();
            } else if (forecastController.errorMessage.value.isNotEmpty) {
              return Expanded(
                  child: Center(
                      child: Text(
                          'Error: ${forecastController.errorMessage.value}')));
            }
            final data = forecastController.weatherData.value;
            return Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  "${data.location!.name!}, ${data.location!.region!}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  DateFormatter.formatDateTime(data.location!.localtime!),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      key: UniqueKey(),
                      fit: BoxFit.contain,
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      filterQuality: FilterQuality.high,
                      fadeInDuration: const Duration(milliseconds: 200),
                      fadeInCurve: Curves.easeInOut,
                      imageUrl: "https:${data.current!.condition!.icon!}",
                      placeholder: (context, url) => Container(
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        color: const Color(0xfff8f8ff),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Container(
                      height: size.width * 0.18,
                      width: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${data.current!.tempC!.round().toString()}°C",
                          style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          data.current!.condition!.text!,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                TodaysForecast(
                  forecastData: data,
                ),
                ThisWeekForecast(
                  forecastData: data,
                )
              ],
            ));
          }),
        ],
      ),
    ));
  }

  Future logoutBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          title: const Text(
            'Are you sure you want to log out?',
          ),
          titleTextStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: MyElevatedButton(
                        elevation: 0,
                        onPress: () {
                          Navigator.pop(context);
                        },
                        buttonContent: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: MyOutlineButton(
                        buttonColor: Colors.white,
                        elevation: 0,
                        onPress: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        borderColor: Colors.grey.shade400,
                        borderWidth: 1,
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
