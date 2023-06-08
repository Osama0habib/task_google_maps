import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hintText, required this.suffixIcon, required this.controller}) : super(key: key);

  final String hintText;
  final Widget suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          suffix: suffixIcon,
          border: OutlineInputBorder(
              gapPadding: 10, borderRadius: BorderRadius.circular(15))),
    );
  }
}
