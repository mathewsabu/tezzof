import 'package:flutter/services.dart';
import 'package:final_year_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/landing_screen.dart';
import 'package:final_year_project/screens/phone_number_screen.dart';
import 'package:final_year_project/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_year_project/screens/registration_screen.dart';
import 'package:final_year_project/screens/vendor_registration_screen.dart';
import 'screens/map_screen.dart';
import 'screens/shop_registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kScaffoldColor, // status bar color
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tezzoff',
      theme: ThemeData(
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: kScaffoldColor,
        primarySwatch: Colors.blue,
      ),
      initialRoute: ShopRegistration
          .id, //LandingScreen.id, //RegistrationScreen.id, // //PhoneScreen.id, //
      routes: {
        LandingScreen.id: (context) => const LandingScreen(),
        PhoneScreen.id: (context) => const PhoneScreen(),
        OtpScreen.id: (context) => const OtpScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        VendorRegistrationScreen.id: (context) =>
            const VendorRegistrationScreen(),
        MapScreen.id: (context) => const MapScreen(),
        ShopRegistration.id: (context) => const ShopRegistration(),
      },
    );
  }
}
