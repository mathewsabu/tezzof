///Screen A new User Sees when the app is first installed

import 'package:final_year_project/screens/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/image_holder.dart';
import 'package:final_year_project/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  static String id = 'landing_screen';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            const Hero(
              tag: 'cupcake',
              child: ImageHolder(
                image: 'images/cupcakes.jpg',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Hello!',
              style: kHeadingTextStyle,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Text(
                'Explore what the world offers near you!',
                textAlign: TextAlign.center,
                style: kSecondaryTextStyle,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, PhoneScreen.id);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                  style: BorderStyle.solid,
                )
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                child: kRegisterButtonChild,
              ),
            ),
            const SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
