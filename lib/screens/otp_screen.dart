import 'package:final_year_project/screens/vendor_registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:final_year_project/constants.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'registration_screen.dart';

class OtpScreen extends StatefulWidget {
  static String id = "otp_screen";
  final String? phoneNumber;
  final String? verificationId;

  const OtpScreen({Key? key, this.phoneNumber, this.verificationId})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool showSpinner = false;
  bool errorayi = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Verify Phone'),
          ),
          body: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              Text(
                'Code is sent to ' + widget.phoneNumber!,
                style: kDefaultTextStyle,
              ),
              const SizedBox(
                height: 40.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Pinput(
                    errorText: 'Invalid OTP',
                    forceErrorState: errorayi,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 80,
                      height: 80,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    errorPinTheme: PinTheme(
                      width: 80,
                      height: 80,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color(0x10000000),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    onCompleted: (pin) async {
                      UserCredential? userCredential;

                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        // print(pin);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId!,
                                smsCode: pin);

                        userCredential = await FirebaseAuth.instance
                            .signInWithCredential(credential);

                        errorayi = true;
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text('Success')));
                      } catch (e) {
                        setState(() {
                          errorayi = true;
                        });

                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text('Invalid OTP')));
                      }
                      // if (userCredential == null) {
                      //   ScaffoldMessenger.of(context)
                      //     ..removeCurrentSnackBar()
                      //     ..showSnackBar(
                      //         const SnackBar(content: Text('Success2')));
                      // }

                      if (errorayi && userCredential != null) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text('Success3')));

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VendorRegistrationScreen()));

                        if (userCredential != null) {
                          String? id = userCredential.user?.uid;
                        }

                        //here you can store user data in backend

                      }

                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
