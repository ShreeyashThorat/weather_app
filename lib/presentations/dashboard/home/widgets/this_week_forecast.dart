import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/forecast_model.dart';
import '../../../../utils/date_formatter.dart';

class ThisWeekForecast extends StatefulWidget {
  final ForecastModel forecastData;
  const ThisWeekForecast({super.key, required this.forecastData});

  @override
  State<ThisWeekForecast> createState() => _ThisWeekForecastState();
}

class _ThisWeekForecastState extends State<ThisWeekForecast> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = widget.forecastData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.025,
        ),
        const Text(
          "This Week",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        ...List.generate(data.forecast!.forecastday!.length, (index) {
          final day = data.forecast!.forecastday![index];
          return Row(
            children: [
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: size.width * 0.2),
                      child: Text(
                        DateFormatter.formatDay(day.date!),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ),
                    Text(
                      "${day.day!.maxtempC!.round()}°C",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Text(
                      "${day.day!.avgtempC!.round()}°C",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      key: UniqueKey(),
                      fit: BoxFit.cover,
                      width: size.width * 0.085,
                      height: size.width * 0.085,
                      fadeInDuration: const Duration(milliseconds: 200),
                      fadeInCurve: Curves.easeInOut,
                      imageUrl: "https:${day.day!.condition!.icon!}",
                      placeholder: (context, url) => Container(
                        width: size.width * 0.085,
                        height: size.width * 0.085,
                        color: const Color(0xfff8f8ff),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      "${day.day!.condition!.text}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          );
        })
      ],
    );
  }
}
