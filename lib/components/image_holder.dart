///




import 'package:flutter/material.dart';

class ImageHolder extends StatelessWidget {

  const ImageHolder({Key key, this.image, this.shrink = false}) : super(key: key);

  final String image;
  final bool shrink;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      margin: const EdgeInsets.all(20.0),
      width: double.infinity,
      height: shrink ? 250.0 : 450.0,
      curve: Curves.fastOutSlowIn,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage('images/cupcakes.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
