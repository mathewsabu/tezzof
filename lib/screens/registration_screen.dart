import 'dart:convert';
import 'dart:ffi';

import 'package:final_year_project/constants.dart';
import 'package:final_year_project/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_year_project/components/image_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int? role;
  String? name;
  String? gender;
  String? ownerName;
  String? buisnessCat;
  String? phoneNumber;
  Future? locations;
  LatLng? savedLocation;
  String? dob;
  Timestamp? dobtime;

  ///List of Items for the Role Selector Drop Down menu!

  final List<DropdownMenuItem<int>> itemsRole = [
    const DropdownMenuItem<int>(
      value: 0,
      child: Text('Vendor'),
    ),
    const DropdownMenuItem<int>(
      value: 1,
      child: Text('Customer'),
    ),
  ];

  final List<DropdownMenuItem<String>> itemsGender = [
    const DropdownMenuItem<String>(
      value: 'Male',
      child: Text('Male'),
    ),
    const DropdownMenuItem<String>(
      value: 'Female',
      child: Text('Female'),
    ),
    const DropdownMenuItem<String>(
      value: 'Other',
      child: Text('Other'),
    ),
  ];

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user;

  ///Functions
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1999),
        firstDate: DateTime(1900),
        lastDate: DateTime(2019));
    if (picked != null) {
      setState(() => dob = '${picked.day}-${picked.month}-${picked.year}');
      dobtime = Timestamp.fromDate(picked);
    }
  }

  @override
  void initState() {
    user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: Text(
                'Tell us about Yourself!',
                style: kSecondaryTextStyle.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),

            ///Widgets to appear in the screen

            ///The dorp down Text field for selecting the Role;
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DropdownButtonFormField(
                items: itemsRole,
                onChanged: (int? value) {
                  setState(() {
                    role = value;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(labelText: 'Role'),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;                    
                  });
                  
                },
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DropdownButtonFormField(
                items: itemsGender,
                onChanged: (String? value) {
                  setState(() {
                    gender = value;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(labelText: 'Gender'),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(labelText: 'DOB'),
                controller: TextEditingController(text: dob),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDate();
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  _fireStore.doc('userdata/${user!.uid}').set({
                    'role': role,
                    'name': name,
                    'gender': gender,
                    'dob': dobtime,
                  }, SetOptions(merge: true));
                },
                style: kButtonStyle,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: kSubmitButtonChild,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
