//import 'dart:html';

import 'dart:convert';

import 'package:final_year_project/constants.dart';
import 'package:final_year_project/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_year_project/components/image_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static String id = 'vendor_registration_screen';

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  String? buisnessName;
  String? ownerName;
  String? buisnessCat;
  String? phoneNumber;
  Future? locations;
  LatLng? savedLocation;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user;
  double? lat = 0.0;
  double? long = 0.0;

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
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Business Name'),
                onChanged: (name) {
                  buisnessName = name;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Owners Name'),
                onChanged: (owner) {
                  ownerName = owner;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Business Category'),
                onChanged: (cat) {
                  buisnessCat = cat;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Phone Number'),
                onChanged: (phone) {
                  phoneNumber = phone;
                },
              ),
            ),

            GestureDetector(
              child: Container(
                height: 200.0,
                width: double.infinity,
                margin: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    image: AssetImage('images/map.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const MapScreen()));
                setState(() {
                  var mapped = jsonDecode('$result');
                  lat = mapped[0];
                  long = mapped[1];
                });
              },
            ),
            Text('Location : $lat , $long'),
            TextButton(
              onPressed: () {
                _fireStore.collection('userdata').add({
                  'uid': user!.uid,
                  'business_name': buisnessName,
                  'owner_name': ownerName,
                  'business_category': buisnessCat,
                  'phone': phoneNumber,
                  'location': GeoPoint(lat!, long!),
                });
              },
              style: kButtonStyle,
              child: kSubmitButtonChild,
            )

            //GoogleMap(initialCameraPosition: CameraPosition(target: LatLng()),)
          ],
        ),
      ),
    );
  }
}
