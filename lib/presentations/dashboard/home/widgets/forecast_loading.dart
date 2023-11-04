import 'package:flutter/material.dart';
import 'package:weather_app/common%20widgets/loading.dart';

class ForeCastLoading extends StatefulWidget {
  const ForeCastLoading({super.key});

  @override
  State<ForeCastLoading> createState() => _ForeCastLoadingState();
}

class _ForeCastLoadingState extends State<ForeCastLoading> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          Loading(height: size.height * 0.04, width: size.width * 0.6),
          Loading(
              margin: EdgeInsets.only(top: size.height * 0.01),
              height: size.height * 0.035,
              width: size.width * 0.45),
          SizedBox(
            height: size.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Loading(
                width: size.width * 0.15,
                height: size.width * 0.15,
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
                  Loading(
                    width: size.width * 0.25,
                    height: size.height * 0.04,
                  ),
                  Loading(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    width: size.width * 0.25,
                    height: size.height * 0.04,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
