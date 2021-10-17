import 'package:chat_app/views/chatrooms.dart';
import 'package:flutter/material.dart';
import '../widgets/widget.dart';
import '../services/database.dart';
import '../services/auth.dart';

class SignUp extends StatefulWidget {
  Function? toggle;
  SignUp({Key? key, this.toggle}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signMeUp() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        print(value);
        Map<String, String> userInfoMap = {
          "name": userNameController.text,
          "email": emailController.text
        };
        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: userNameController,
                                decoration:
                                    textFieldInputDecoration('Username'),
                                style: simpleTextStyle(),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 4) {
                                    return 'Please provide a valid username';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: textFieldInputDecoration('Email'),
                                style: simpleTextStyle(),
                                validator: (value) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value.toString())) {
                                    return null;
                                  } else {
                                    return "Please provide a valid email";
                                  }
                                },
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
                                  decoration:
                                      textFieldInputDecoration('Password'),
                                  style: simpleTextStyle()),
                            ],
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            'Forgot Password?',
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xff007eF4),
                                Color(0xff2A75BC)
                              ])),
                          child: Text('Sign up', style: meduimTextStyle()),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Text(
                          'Sign up with Google',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: meduimTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Sign In Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
