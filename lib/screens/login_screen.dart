import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var _myOpacity = 0.0;

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

bool loggedIn = false;
bool isSelected = false;
final loginFormkey = GlobalKey<FormState>();
bool isVisible = true;
Icon passIcon = const Icon(Icons.visibility_off);
String _errorText = "";

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _myOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColors.scaffoldBgColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.scaffoldBgColor,
            Color(0xff09203f),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: loginFormkey,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * .1,
                  ),
                  AnimatedOpacity(
                    opacity: _myOpacity,
                    duration: const Duration(seconds: 2),
                    child: Text(
                      "MovieZ",
                      style:
                          TextStyle(fontSize: mq.width * .15, color: Colors.red),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  TextFormField(
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      errorStyle: TextStyle(
                          color: Colors.red, fontSize: mq.width * .04),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      hintText: 'Enter your Email',
                      label: Text(
                        "Email",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No User for this email';
                      } else if (!EmailValidator.validate(value)) {
                        return ' Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  TextFormField(
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    controller: passwordController,
                    obscureText: isVisible,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0)),
                      errorStyle: TextStyle(
                          color: Colors.red, fontSize: mq.width * .04),
                      prefixIcon: const Icon(Icons.key_rounded),
                      label: Text(
                        "Password",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isVisible) {
                              isVisible = false;
                              passIcon = const Icon(Icons.visibility);
                            } else {
                              isVisible = true;
                              passIcon = const Icon(Icons.visibility_off);
                            }
                          });
                        },
                        icon: passIcon,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: isSelected, onChanged: (bool? newValue){
                            isSelected = newValue!;
                            if (isSelected) {
                              saveRememberMePreference(true);
                            } else {
                              saveRememberMePreference(false);
                            }
                            setState(() {

                            });
                          }),
                          Text("Remeber Me"),
                        ],
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                      }, child: const Text("Forgot Password ?"))
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (loginFormkey.currentState!.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen())))
                            .onError((error, stackTrace) {
                          setState(() {
                            _errorText = "Invalid Email or Password";
                            passwordController.clear();
                          });
                        });
                      }
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(fontSize: mq.width * .04),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an Account ?",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.red, fontSize: mq.width * .05),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  Text(
                    _errorText,
                    style:
                        TextStyle(color: Colors.red, fontSize: mq.width * .05),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// To save the "Remember Me" preference
void saveRememberMePreference(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('rememberMe', value);
}
