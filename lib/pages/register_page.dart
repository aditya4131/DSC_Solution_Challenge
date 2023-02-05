import 'package:dsc_project/service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String password = "";
  String fullName = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome Onboard!",
                  style: TextStyle(
                      color: Color(0xFFB0D0C0C),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 7),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  obscureText: false,
                  decoration: textInputDecoration.copyWith(
                    labelText: "  Full Name",
                    prefix: Icon(Icons.person, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  onChanged: (val) {
                    setState(() {
                      fullName = val;
                    });
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a valid name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
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
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        register();
                      },
                    )),
                const SizedBox(
                  height: 60,
                ),
                Text.rich(TextSpan(
                  text: "Have an account? ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Sign In",
                        style: const TextStyle(
                          color: Color(0xFFB0B0899),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            nextScreen(
                              context,
                              const LoginPage(),
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

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          //saving the shared preference state
          await HelperFunctions.saveUserLogInStatus(true);
          await HelperFunctions.saveUserEmail(email);
          await HelperFunctions.saveUserName(fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
