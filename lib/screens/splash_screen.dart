import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
bool finalValue = false;

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    getRememberMePreference().whenComplete(() async{
      Timer(const Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return finalValue == false ? const LoginScreen(): const HomeScreen();
        }));
      });
    });
  }

  // To retrieve the "Remember Me" preference
  Future getRememberMePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedValue = prefs.getBool('rememberMe');
    setState(() {
      finalValue = obtainedValue!;
    });
  }

  @override
  Widget build(BuildContext context) {

    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [MyColors.scaffoldBgColor,Color(0xff09203f),],
              begin: Alignment.topCenter,end: Alignment.bottomCenter
          ),
        ),
        child: Center(
          child: Text("MovieZ",style: GoogleFonts.aBeeZee(fontSize: mq.width * .2,color: Colors.red),),
        ),
      ),
    );
  }
}
