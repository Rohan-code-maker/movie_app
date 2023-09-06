import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/widgets/back_button.dart';

import '../colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  String _errorText = "";

  void _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      _errorText = "Please Check Your Email";
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    } catch (error) {
      _errorText = "Something Went Wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const BackBtn(),
        centerTitle: true,
        title: const Text('Forgot Password'),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "MovieZ",
                  style:
                  TextStyle(fontSize: mq.width * .15, color: Colors.red),
                ),
                const Padding(padding: EdgeInsets.all(11.0)),
                TextFormField(
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
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
                ElevatedButton(
                  onPressed: () {
                    _resetPassword(context);
                  },
                  child: const Text('Reset Password'),
                ),
                Text(_errorText,style: TextStyle(fontSize: mq.width * .05),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
