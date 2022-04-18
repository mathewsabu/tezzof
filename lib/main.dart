import 'package:final_year_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/landing_screen.dart';
import 'package:final_year_project/screens/phone_number_screen.dart';
import 'package:final_year_project/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldColor,
        primarySwatch: Colors.blue,
      ),
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id : (context) => const LandingScreen(),
        PhoneScreen.id : (context) => const PhoneScreen(),
        OtpScreen.id : (context) => const OtpScreen(),



      },
    );
  }
}