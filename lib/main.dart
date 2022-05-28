import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/screens/customer_home_screen.dart';
import 'package:final_year_project/services/authentication_service.dart';
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
import 'package:provider/provider.dart';
import 'services/authentication_service.dart';

Future<void> main() async {
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
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tezzoff',
        theme: ThemeData(
          appBarTheme: kAppBarTheme,
          scaffoldBackgroundColor: kScaffoldColor,
          primarySwatch: Colors.blue,
        ),
        home: initialRoute(),
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
      ),
    );
  }
}

///Logic for Starting Home Screen;

class initialRoute extends StatelessWidget {
  const initialRoute({Key? key}) : super(key: key);

  Future<String?> checkRegistration({var db, User? firebaseUser}) async {
    var data;

    final docRef = await db.collection("userdata").doc(firebaseUser!.uid);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );

    if (data["role"] == null) {
      return 'not';
    } else if (data["role"] == 0) {
      return 'vendor';
    } else {
      return 'customer';
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final _firestore = context.read<AuthenticationService>().firestore;
    String? role;
    if (firebaseUser == null) {
      return LandingScreen();
    } else {
      return FutureBuilder(
        future: checkRegistration(firebaseUser: firebaseUser, db: _firestore),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            role = snapshot.data;
            print('Role');

            if (role == 'not') {
              return const RegistrationScreen();
            } else if (role == 'customer') {
              return const CustomerHomeScreen();
            } else {
              return const RegistrationScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // if (role == 'not') {
          //   return const RegistrationScreen();
          // } else if (role == 'customer') {
          //   return const CustomerHomeScreen();
          // } else {
          //   return const RegistrationScreen();
          // }
        },
      );
    }
  }
}
