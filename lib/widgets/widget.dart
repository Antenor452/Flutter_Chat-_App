import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 40,
    ),
  );
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

TextStyle simpleTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle meduimTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 17);
}

Widget textButton(String text, Color colour, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
            colors: [Color(0xff007eF4), Color(0xff2A75BC)])),
    child: Text(
      text,
      style: simpleTextStyle(),
    ),
  );
}
