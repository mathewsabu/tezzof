import 'package:final_year_project/components/role_selector.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: Column(
          //direction: Axis.vertical,
          children: const [

            Image(image: AssetImage('images/cupcakes.jpg')),

            RoleSelector()
          ],
        ),
      ),
    );
  }
}
