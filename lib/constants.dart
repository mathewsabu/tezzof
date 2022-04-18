import 'package:flutter/material.dart';

const Color kScaffoldColor = Color(0xFFDFE5F6); ///Color of the Scaffold


///Color of The Heading Text used in Landing Screen
const kHeadingTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 50.0,
  color: Color(0xFF58536B),
);


const Color kOutlineButtonColor = Color(0xFF58536B);


const kSecondaryTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 15.0,
  color: Color(0xFF787389),
);

const kRegisterButtonChild = Text(
  'Register',
  style: kSecondaryTextStyle,
);

const kSubmitButtonChild = Text(
  'Submit',
  style: kSecondaryTextStyle,
);


///TextField's decoration properties

const InputDecoration kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(Icons.phone),

  //label: Text('Phone Number'),
  labelText: 'Mobile Number',
  labelStyle: TextStyle(decorationStyle: TextDecorationStyle.dotted),
  floatingLabelBehavior: FloatingLabelBehavior.never,
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white10, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);