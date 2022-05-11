import 'package:flutter/material.dart';
import 'package:final_year_project/components/string_input_box.dart';
import 'package:final_year_project/components/add_images.dart';
import 'package:final_year_project/constants.dart';
import 'dart:convert';
import 'map_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopRegistration extends StatefulWidget {
  const ShopRegistration({Key? key}) : super(key: key);
  static String id = 'shop_registration_screen';

  @override
  State<ShopRegistration> createState() => _ShopRegistrationState();
}

class _ShopRegistrationState extends State<ShopRegistration> {
  ///variables
  String? businessName;
  String? phone;
  String? website;
  String? email;
  String? cat;

  double? lat;
  double? long;

  List<XFile>? images = [];
  final ImagePicker _picker = ImagePicker();

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user;
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  ///Menu Items for category of the Business
  final List<DropdownMenuItem<String>> itemsCat = [
    const DropdownMenuItem<String>(
      value: 'grocery',
      child: Text('Grocery'),
    ),
    const DropdownMenuItem<String>(
      value: 'fr&veg',
      child: Text('Fruits and Vegetables'),
    ),
    const DropdownMenuItem<String>(
      value: 'supermarket',
      child: Text('Supermarket'),
    ),
    const DropdownMenuItem<String>(
      value: 'electro',
      child: Text('Electronics'),
    ),
    const DropdownMenuItem<String>(
      value: 'cloth',
      child: Text('Clothing'),
    ),
    const DropdownMenuItem<String>(
      value: 'res&bakery',
      child: Text('Restaurant & Bakery'),
    ),
    const DropdownMenuItem<String>(
      value: 'meds',
      child: Text('Medicine'),
    ),
    const DropdownMenuItem<String>(
      value: 'shoes&bags',
      child: Text('Shoes and Bags'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter Business Details'),
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: AddImages(
                width: double.infinity,
                height: 200.0,
              ),
            ),

            ///Input - Name of the business
            StringInputBox(
              label: 'Business Name',
              onChanged: (value) {
                setState(() {
                  businessName = value;
                });
              },
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DropdownButtonFormField(
                items: itemsCat,
                onChanged: (String? value) {
                  setState(() {
                    cat = value;
                  });
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Business Type'),
              ),
            ),

            //Input - phone Number of the business
            StringInputBox(
              label: 'Phone Number',
              keyboard: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
            ),

            ///Input - Email address
            StringInputBox(
              label: 'Email',
              keyboard: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),

            ///Input - website
            StringInputBox(
              label: 'Website',
              keyboard: TextInputType.url,
              onChanged: (value) {
                setState(() {
                  website = value;
                });
              },
            ),

            ///Widget for setting the Shop Lcation

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  user = _auth.currentUser;
                  _fireStore.doc('shopdata/$businessName${user!.uid}').set({
                    'uid' : user!.uid,
                    'businessName': businessName,
                    'phone': phone,
                    'website': website,
                    'email': email,
                    'cat' : cat,
                  }, SetOptions(merge: true));
                },
                style: kButtonStyle,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
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
