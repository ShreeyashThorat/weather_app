import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class MyElevatedButton extends StatefulWidget {
  final Function() onPress;
  final Color? buttonColor;
  final double? elevation;
  final Color? textColor;
  final Widget buttonContent;
  final BorderSide? borderSide;
  const MyElevatedButton(
      {Key? key,
      required this.onPress,
      required this.buttonContent,
      this.buttonColor,
      this.elevation,
      this.textColor,
      this.borderSide})
      : super(key: key);

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(
                widget.buttonColor ?? Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              side: widget.borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(6.0),
            ))),
        onPressed: widget.onPress,
        child: widget.buttonContent);
  }
}

// Elevated Button
class MyButton extends StatefulWidget {
  final Function() onPress;
  final Widget buttonContent;
  final Color? buttonColor;
  final double? elevation;
  final Color? textColor;
  const MyButton(
      {Key? key,
      required this.onPress,
      required this.buttonContent,
      this.buttonColor,
      this.elevation,
      this.textColor})
      : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(
                widget.buttonColor ?? ColorTheme.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ))),
        onPressed: widget.onPress,
        child: widget.buttonContent);
  }
}

// Outline Button

class MyOutlineButton extends StatefulWidget {
  final double elevation;
  final Color buttonColor;
  final Function() onPress;
  final Widget child;
  final double borderWidth;
  final Color borderColor;
  const MyOutlineButton(
      {Key? key,
      required this.buttonColor,
      required this.child,
      required this.elevation,
      required this.onPress,
      required this.borderColor,
      required this.borderWidth})
      : super(key: key);

  @override
  State<MyOutlineButton> createState() => _MyOutlineButtonState();
}

class _MyOutlineButtonState extends State<MyOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor:
                MaterialStateProperty.all<Color>(widget.buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              side: BorderSide(
                  width: widget.borderWidth, color: widget.borderColor),
              borderRadius: BorderRadius.circular(6.0),
            ))),
        onPressed: widget.onPress,
        child: widget.child);
  }
}
