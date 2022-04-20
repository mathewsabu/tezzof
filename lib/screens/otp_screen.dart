import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:final_year_project/constants.dart';

class OtpScreen extends StatefulWidget {
  static String id = "otp_screen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Verify Phone'),
        ),
        body: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            const Text(
              'Code is sent to +91 6282796936',
              style: kDefaultTextStyle,
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 80,
                    height: 80,
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  onCompleted: (pin) {
                    print(pin);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
