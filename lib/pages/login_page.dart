import 'package:dsc_project/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 80,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                      color: Color(0xFFB0D0C0C),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 7),
                ),
                SizedBox(
                  height: 60,
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(120.0),
                  //   ),
                  // ),
                ),
                TextFormField(
                  obscureText: false,
                  decoration: textInputDecoration.copyWith(
                    labelText: "  Email",
                    prefix: Icon(Icons.email, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: "  Password",
                    prefix: Icon(Icons.lock, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Password must be at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 440.0,
                    height: 70.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        login();
                      },
                    )),
                const SizedBox(
                  height: 60,
                ),
                Text.rich(TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(
                          color: Color(0xFFB0B0899),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            nextScreen(
                              context,
                              const RegisterPage(),
                            );
                          }),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() {}
}
