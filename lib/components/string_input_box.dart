import 'package:flutter/material.dart';
import 'package:final_year_project/constants.dart';

class StringInputBox extends StatefulWidget {
  StringInputBox({Key? key, this.label, this.onChanged, this.keyboard}) : super(key: key);

  void Function(String)? onChanged;
  String? label;
  TextInputType? keyboard = TextInputType.name;

  @override
  State<StringInputBox> createState() => _StringInputBoxState();
}

class _StringInputBoxState extends State<StringInputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: TextFormField(
        decoration: kTextFieldDecoration.copyWith(labelText: widget.label),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboard,
      ),
    );
  }
}
