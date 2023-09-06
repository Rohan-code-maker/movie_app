import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/widgets/back_button.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

var myOpacity = 0.0;


TextEditingController userController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool loggedIn = false;
final signupFormkey = GlobalKey<FormState>();
bool isVisible = true;
bool isVisible2 = true;
Icon passIcon = const Icon(Icons.visibility_off);
Icon passIcon2 = const Icon(Icons.visibility_off);

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        myOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const BackBtn(),
        elevation: 0,
        centerTitle: true,
        title: const Text("SignUp Screen",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: MyColors.scaffoldBgColor,
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
            key: signupFormkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Column(
                children: [
                  AnimatedOpacity(opacity: myOpacity,duration: const Duration(seconds: 2),
                  child: Text("MovieZ",style: TextStyle(fontSize: mq.width * .15,color: Colors.red),)),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  TextFormField(
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    controller: userController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: mq.width * .04),
                      prefixIcon: const Icon(Icons.person),
                      label: Text(
                        "Username",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                      hintText: "Enter the Username",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Username";
                      } else {
                        return null;
                      }
                    },
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
                      errorStyle: TextStyle(color: Colors.red, fontSize: mq.width * .04),
                      prefixIcon: const Icon(Icons.lock),
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
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#&*~]).{6,}$',);
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      if (!regex.hasMatch(value)) {
                        return "Password must be minimum\n"
                            "at least 6 characters or more\n1 Upper Case,\n1 Lower Case,\n1 Digit,\n1 Special Character";
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  TextFormField(
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    obscureText: isVisible2,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: mq.width * .04),
                      prefixIcon: const Icon(Icons.lock),
                      label: Text(
                        "Confirm Password",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isVisible2) {
                              isVisible2 = false;
                              passIcon2 = const Icon(Icons.visibility);
                            } else {
                              isVisible2 = true;
                              passIcon2 = const Icon(Icons.visibility_off);
                            }
                          });
                        },
                        icon: passIcon2,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter valid Password";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(11.0)),
                  ElevatedButton(
                    onPressed: () {
                      if (signupFormkey.currentState!.validate()) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              ),
                            )
                            .onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      }
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: mq.width * .04,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account ?",
                        style: TextStyle(fontSize: mq.width * .04),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.red, fontSize: mq.width * .05),
                          ))
                    ],
                  )
                  // ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
