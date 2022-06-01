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
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:final_year_project/services/storage_service.dart';

class ShopRegistration extends StatefulWidget {
  const ShopRegistration({Key? key}) : super(key: key);
  static String id = 'shop_registration_screen';

  @override
  State<ShopRegistration> createState() => _ShopRegistrationState();
}

class _ShopRegistrationState extends State<ShopRegistration> {
  ///variables
  String? buisnessName;
  String? phone;
  String? website;
  String? email;
  String? cat;
  bool isloading = false;

  double? lat;
  double? long;
  final Storage storage = Storage();

  List<XFile>? images = [];
  final ImagePicker _picker = ImagePicker();

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user;
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

  ///Functions

  @override
  void initState() {
    _getStoragePermission();
    user = _auth.currentUser;
    print(user!.uid);
    super.initState();
  }

  Future _getStoragePermission() async {
    bool permissionGranted;
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  ///Function to Upload Images in a XFile List to the Cloud
  Future<List<String>> uploadImages(List<XFile> l) async {
    List<String> imageLinks = [];
    if (l.isNotEmpty) {
      for (int i = 0; i < l.length; i++) {
        await storage.uploadItemFile(fileName: l[i].name, filePath: l[i].path);
        String? downloadLink = await storage.getShopDownloadLink(
            fileName: l[i].name, filePath: l[i].path);
        imageLinks.add(downloadLink!);
      }
      return imageLinks;
    } else {
      return imageLinks;
    }
  }

  ///UI

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter Business Details'),
        ),
        body: ListView(
          children: [
            ///Image Displaying Widget with selector
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
                  buisnessName = value;
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

            ///Button for Submitting the details collected and Uploading the Images to the reference
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    isloading = true;
                  });
                  List<String> imageLinks =
                      await uploadImages(AddImages.images!);

                  await _fireStore
                      .doc('shopdata/$buisnessName ${user!.uid}')
                      .set({
                    'uid': user!.uid,
                    'buisnessName': buisnessName,
                    'phone': phone,
                    'website': website,
                    'email': email,
                    'cat': cat,
                    'location': GeoPoint(lat!, long!),
                    'images': imageLinks,
                  }, SetOptions(merge: true));

                  setState(() {
                    isloading = false;
                  });
                },
                style: kButtonStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: isloading
                      ? const CircularProgressIndicator()
                      : kSubmitButtonChild,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
