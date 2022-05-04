import 'package:final_year_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static String id = 'vendor_registration_screen';

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {



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
                onChanged: (name) {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Owners Name'),
                onChanged: (name) {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Business Category'),
                onChanged: (name) {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: TextFormField(
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Phone Number'),
                onChanged: (name) {},
              ),
            ),
            Container(
              height: 200.0,
              child: const GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14.4746,
                ),

              ),
            )

            //GoogleMap(initialCameraPosition: CameraPosition(target: LatLng()),)
          ],
        ),
      ),
    );
  }
}
