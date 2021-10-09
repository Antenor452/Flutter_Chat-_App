import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return AppBar(title: Image.asset("assets/images/logo.png"));
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextFieldTextStyle() {
  return const TextStyle(color: Colors.white);
}
