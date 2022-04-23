///




import 'package:flutter/material.dart';

class ImageHolder extends StatelessWidget {

  final String image1;
  final bool shrink;

  const ImageHolder({Key? key, required this.image1 , this.shrink = false}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      margin: const EdgeInsets.all(20.0),
      width: double.infinity,
      height: shrink ? 0 : 400.0,
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(image1),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
