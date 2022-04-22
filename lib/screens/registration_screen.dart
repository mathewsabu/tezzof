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
        body: Flex(
          direction: Axis.vertical,
          children: const [
            Text('Registration Page'),
          ],
        ),
      ),
    );
  }
}
