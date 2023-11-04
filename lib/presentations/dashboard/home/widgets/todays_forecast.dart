import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/forecast_model.dart';
import '../../../../utils/color_theme.dart';
import '../../../../utils/date_formatter.dart';

class TodaysForecast extends StatefulWidget {
  final ForecastModel forecastData;
  const TodaysForecast({super.key, required this.forecastData});

  @override
  State<TodaysForecast> createState() => _TodaysForecastState();
}

class _TodaysForecastState extends State<TodaysForecast> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getIndex();
    super.initState();
  }

  void getIndex() {
    for (int i = 0;
        i < widget.forecastData.forecast!.forecastday![0].hour!.length;
        i++) {
      final hourlyData = widget.forecastData.forecast!.forecastday![0].hour!;
      if (DateFormatter.formatTime(hourlyData[i].time!) ==
          DateFormatter.formatTime(DateTime.now().toString())) {
        scrollToIndex(10);
        break;
      }
    }
  }

  void scrollToIndex(int index) {
    if (scrollController.hasClients) {
      RenderBox itemRenderBox = context.findRenderObject() as RenderBox;
      double itemX = itemRenderBox.size.width * 0.25 * index;
      double scrollTo = itemX -
          MediaQuery.of(context).size.width / 2 +
          itemRenderBox.size.width / 2;
      scrollTo = scrollTo.clamp(0.0, scrollController.position.maxScrollExtent);
      scrollController.animateTo(
        scrollTo,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = widget.forecastData;
    List<TodayForeCast> todayForeCast = [
      TodayForeCast(
          title: "Pressure", number: "${data.current!.pressureMb!.round()}mb"),
      TodayForeCast(
          title: "Visibility", number: "${data.current!.visKm!.round()} Km"),
      TodayForeCast(
          title: "Humidity", number: "${data.current!.humidity!.round()}%")
    ];
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.025),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorTheme.primaryColor.withOpacity(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.027,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(todayForeCast.length, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      todayForeCast[index].title!,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      todayForeCast[index].number!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                );
              })
            ],
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Row(
              children: [
                ...List.generate(data.forecast!.forecastday![0].hour!.length,
                    (index) {
                  final hourlyData =
                      data.forecast!.forecastday![0].hour![index];
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DateFormatter.formatTime(hourlyData.time!) ==
                              DateFormatter.formatTime(
                                  DateTime.now().toString())
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormatter.formatTime(hourlyData.time!),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Text(
                          "${hourlyData.tempC!.round().toString()}°C",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        CachedNetworkImage(
                          key: UniqueKey(),
                          fit: BoxFit.cover,
                          width: size.width * 0.085,
                          height: size.width * 0.085,
                          fadeInDuration: const Duration(milliseconds: 200),
                          fadeInCurve: Curves.easeInOut,
                          imageUrl: "https:${hourlyData.condition!.icon!}",
                          placeholder: (context, url) => Container(
                            width: size.width * 0.085,
                            height: size.width * 0.085,
                            color: const Color(0xfff8f8ff),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TodayForeCast {
  final String? title;
  final String? number;
  TodayForeCast({this.title, this.number});
}
