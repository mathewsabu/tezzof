import 'package:final_year_project/constants.dart';
import 'package:flutter/material.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static String id = 'vendor_registration_screen';

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
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
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Business Name'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Owners Name'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Business Category'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Phone Number'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Name is'
                ),
                onChanged: (name){
                },
              ),
            ),
          ],

        ),
      ),
    );
  }
}
