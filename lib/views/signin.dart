// ignore_for_file: prefer_const_constructors

import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chatrooms.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  var toggle;
  SignIn({Key? key, this.toggle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  void changescreen() {
    widget.toggle();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    AuthMethods authMethods = AuthMethods();
    DatabaseMethods databaseMethods = DatabaseMethods();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    QuerySnapshot? userdetails;
    Future<String> getusername(String email) async {
      userdetails = await databaseMethods.getUserByEmail(emailController.text);
      String username = userdetails!.docs.first["name"];
      print(username);
      return username;
    }

    void signIn() async {
      if (formkey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        authMethods
            .signInWithEmailAndPassword(
                emailController.text, passwordController.text)
            .then((value) {
          if (value != null) {
            String username = getusername(emailController.text).toString();

            HelperFunctions.saveuserLoggedInSharedPreference(true);
            HelperFunctions.saveuserEmailSharedPreference(emailController.text);
            HelperFunctions.saveusernameSharedPreference(username);
          }
        });
      }
    }

    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString())) {
                            return null;
                          } else {
                            return "Please provide a valid email";
                          }
                        },
                        controller: emailController,
                        decoration: textFieldInputDecoration('Email'),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.length > 6) {
                              return null;
                            } else {
                              return "Please provide a password of valid length";
                            }
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: textFieldInputDecoration('Password'),
                          style: simpleTextStyle()),
                    ],
                  )),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Forgot Password?',
                    style: simpleTextStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: signIn,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          colors: [Color(0xff007eF4), Color(0xff2A75BC)])),
                  child: Text('Sign in', style: meduimTextStyle()),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: meduimTextStyle(),
                  ),
                  GestureDetector(
                    onTap: changescreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
