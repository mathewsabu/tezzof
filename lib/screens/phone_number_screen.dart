import 'package:final_year_project/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/image_holder.dart';
//import 'package:flutter/rendering.dart';
import 'package:final_year_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneScreen extends StatefulWidget {
  static String id = 'phone_number_screen';

  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  String? phoneNumber;
  bool shrink = false;
  bool showSpinner = false;
  final _fireStore = FirebaseFirestore.instance;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Continue with Phone'),
          ),
          body: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              ///Image of the Cupcake Restraunt wrapped with Hero animation

              Hero(
                tag: 'cupcake',
                child: ImageHolder(
                  image1: 'images/cupcakes.jpg',
                  shrink: shrink,
                ),
              ),

              ///Text "You'll receive a 6 digit code to verify next"

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Text(
                  'You\'ll receive a 6 digit code to verify next.',
                  textAlign: TextAlign.center,
                  style: kSecondaryTextStyle,
                ),
              ),

              ///Text Box for entering internation phone numbers

              Container(
                padding: const EdgeInsets.all(6.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: kScaffoldColor,
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber;
                  },
                  onTap: () {
                    setState(() {
                      shrink = true;
                    });
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  spaceBetweenSelectorAndTextField: 0,
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: PhoneNumber(
                      isoCode: 'IN'), //enter country code for the default value
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                  textFieldController: controller,
                ),
              ),

              ///Button for submitting

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    //Navigator.pushNamed(context, OtpScreen.id);

                    ///Function to verify the phone number and and send the otp
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber!,
                      verificationCompleted:
                          (PhoneAuthCredential phoneAuthCredential) async {
                        User? user;
                        bool error = false;
                        try {
                          user = (await FirebaseAuth.instance
                                  .signInWithCredential(phoneAuthCredential))
                              .user!;
                        } catch (e) {
                          print("Failed to sign in: " + e.toString());
                          error = true;
                        }
                        if (!error && user != null) {
                          String id = user.uid;
                          // _fireStore.collection('userdata').add({
                          //   'uid' : id,
                          // });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen()));
                        }
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print('failed');
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        setState(() {
                          showSpinner = false;
                        });
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                phoneNumber: phoneNumber,
                                verificationId: verificationId,
                              ),
                            ));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  style: kButtonStyle,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                    child: kSubmitButtonChild,
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
