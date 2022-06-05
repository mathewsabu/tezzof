import 'package:final_year_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';

class SelectCategoryWidget extends StatefulWidget {
  static String? finalValue;
  final List<String> categories;
  const SelectCategoryWidget({Key? key, this.categories = const []})
      : super(key: key);

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  List<String> categories1 = [];
  List<DropdownMenuItem<String>> itemsCat = [];

  @override
  void initState() {
    categories1 = widget.categories;
    getList(categories1);
    super.initState();
  }

  void getList(categories) {
    for (int i = 0; i < categories.length; i++) {
      DropdownMenuItem<String> temp = DropdownMenuItem(
        value: categories[i],
        child: Text(categories[i]),
      );

      itemsCat.add(temp);
    }

    itemsCat.add(DropdownMenuItem(
        value: 'new',
        child: Row(
          children: const [Text('Add Category'), Icon(Icons.add)],
        )));
  }

  @override
  Widget build(BuildContext context) {
    String? value1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: DropdownButtonFormField(
        value: value1,
        items: itemsCat,
        onChanged: (String? value) async {
          var controller = TextEditingController();
          if (value == 'new') {
            String? temp;
            await NAlertDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              blur: 10,
              title: const Text("Add Category"),
              content: TextField(
                controller: controller,
              ),
              actions: <Widget>[
                TextButton(
                    child: const Text("Add"),
                    onPressed: () {
                      temp = controller.text;
                      Navigator.pop(context);
                    })
              ],
            ).show(context);
            if (temp != null && temp != '') {
              setState(() {
                itemsCat.insertAll(0, [
                  (DropdownMenuItem(
                    value: temp,
                    child: Text(temp!),
                  ))
                ]);
                value1 = temp;
              });
            }
          }
          SelectCategoryWidget.finalValue = value;
        },
        decoration: kTextFieldDecoration.copyWith(labelText: 'Business Type'),
      ),
    );
  }
}
