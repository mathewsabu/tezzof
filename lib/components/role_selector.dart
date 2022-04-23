import 'package:flutter/material.dart';
import 'image_holder.dart';

class RoleSelector extends StatefulWidget {
  const RoleSelector({Key? key}) : super(key: key);

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          ImageHolder(
            image1: 'images/cupcakes.jpg',
          ),
        ],
      ),
    );
  }
}
