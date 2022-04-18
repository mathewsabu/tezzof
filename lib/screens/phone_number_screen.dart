import 'package:final_year_project/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/image_holder.dart';
//import 'package:flutter/rendering.dart';
import 'package:final_year_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneScreen extends StatefulWidget {
  static String id = 'phone_number_screen';

  const PhoneScreen({Key key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  String number;
  bool shrink = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            Hero(
              tag: 'cupcake',
              child: ImageHolder(
                image: 'images/cupcakes.jpg',
                shrink: shrink,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: kTextFieldDecoration,
                onTap: () {
                  setState(() {
                    shrink = true;
                  });
                },
                onChanged: (value) {
                  number = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: OutlinedButton(
                onPressed: () async {
                  //Navigator.pushNamed(context, OtpScreen.id);
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91'+ number,
                    verificationCompleted: (PhoneAuthCredential credential) {
                      print('Verification finish');
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print('failed');
                    },
                    codeSent: (String verificationId, int resendToken) {
                      Navigator.pushNamed(context, OtpScreen.id);
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40.0),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                  child: kSubmitButtonChild,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
