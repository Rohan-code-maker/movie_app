import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/screens/signup_screen.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieZ',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark
    ),
      home: const SplashScreen(),
    );
  }
}
bool _iconBool =false;

IconData _iconLight=Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light
);

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark
);


