import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? inputType;
  final Function(String)? onChange;
  final int? maxLength;
  final bool? isObscure;
  final Widget? preffix;
  final Widget? suffix;
  final int? maxLines;
  final bool readOnly;
  final double? radius;
  final double? verticalPadding;
  final bool autofocus;
  final Function()? onTap;
  final Color? fillColor;
  final bool? filled;
  final String fieldType;
  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onChange,
      this.maxLength,
      this.isObscure = false,
      this.inputType,
      this.maxLines,
      this.suffix,
      this.preffix,
      this.radius,
      this.verticalPadding,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.fillColor,
      this.filled,
      required this.fieldType})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscure = false;

  @override
  void initState() {
    setState(() {
      obscure = widget.isObscure!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: obscure,
      keyboardType: widget.inputType,
      onChanged: widget.onChange,
      maxLines: widget.isObscure == true ? 1 : widget.maxLines,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 15,
              color: ColorTheme.hintText,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
          ),
          fillColor: widget.fillColor,
          filled: widget.filled,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding ?? 15, horizontal: 15),
          prefixIcon: widget.preffix,
          suffixIcon: widget.isObscure == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  splashColor: Colors.transparent,
                  icon: obscure == true
                      ? const Icon(
                          Icons.visibility_rounded,
                          color: Colors.black54,
                          size: 22,
                        )
                      : const Icon(
                          Icons.visibility_off_rounded,
                          color: Colors.black54,
                          size: 22,
                        ))
              : widget.suffix),
      cursorColor: Colors.black,
      onTap: widget.onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter ${widget.fieldType}';
        }
        //********* CHECK NUMBER *******/

        if (widget.fieldType == "Phone" && !validatePhone(value)) {
          return 'Please Enter valid Phone Number';
        }

        if (widget.fieldType == 'Email' && !validateEmail(value)) {
          return 'Please Enter valid Email';
        }
        return null;
      },
      onSaved: (newValue) => widget.controller.text = newValue!,
    );
  }
}

bool validatePhone(String phone) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  return regExp.hasMatch(phone);
}

bool validateEmail(String email) {
  RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  return emailReg.hasMatch(email);
}
