import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

const PinTheme kOtpTheme =
    PinTheme(margin: EdgeInsets.symmetric(horizontal: 10.0));

///Default Color of the Scaffold
const Color kScaffoldColor = Color(0xFFDFE5F6);

///Style of The Heading Text used in Landing Screen
const kHeadingTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 50.0,
  color: Color(0xFF58536B),
);

const Color kOutlineButtonColor = Color(0xFF58536B);

/// Default Text Style
/// TextStyle for the normal Texts that appear in Otp Screen etc eg: Otp Sent to phone no +91 xxxxxxxxx
const kDefaultTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18.0,
  color: Colors.black45,
  fontWeight: FontWeight.w500,
);

///TextStyle for text inside the Buttons such as register and Submit
const kSecondaryTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18.0,
  color: Color(0xFF787389),
);

const kButtonTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18.0,
  color: Colors.black,
);

const kRegisterButtonChild = Text(
  'Register',
  style: kButtonTextStyle,
);

const kSubmitButtonChild = Text(
  'Submit',
  style: kButtonTextStyle,
);

///TextField's - used for entering phone number, decoration properties
const InputDecoration kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white60,
  //hintText: 'Name',


  //label: Text('Phone Number'),
  //labelText: 'Name',
  labelStyle: TextStyle(decorationStyle: TextDecorationStyle.dotted),
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.white60, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white10, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);

///Theme for the AppBar

const kAppBarTheme = AppBarTheme(
  color: kScaffoldColor,
  foregroundColor: Colors.black,
  centerTitle: true,
  elevation: 0,
  titleTextStyle: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.black87,
  ),
);

///Style for Buttons Such as Register and Submit
ButtonStyle kButtonStyle = OutlinedButton.styleFrom(
  minimumSize: const Size(double.infinity, 20.0),
  backgroundColor: const Color(0xFFFFDC3D),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);