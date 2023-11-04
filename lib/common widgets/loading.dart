import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final EdgeInsetsGeometry? margin;
  const Loading(
      {Key? key,
      required this.height,
      required this.width,
      this.margin,
      this.radius = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.grey.shade100),
        ));
  }
}
