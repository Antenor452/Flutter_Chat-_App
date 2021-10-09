// ignore_for_file: prefer_const_constructors

import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 40,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextField(
              decoration: textFieldInputDecoration('Email'),
              style: simpleTextFieldTextStyle(),
            ),
            TextField(
                decoration: textFieldInputDecoration('Password'),
                style: simpleTextFieldTextStyle()),
            SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Forgot Password?',
                  style: simpleTextFieldTextStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
