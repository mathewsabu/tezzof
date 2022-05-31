import 'package:flutter/material.dart';
import 'package:final_year_project/constants.dart';

///Class for implementing Horizontally Scrollable Category Selector

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);
  static int selection = 0;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selection = 0;

  ///Varialble to keep track which Category was selected
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ListView(
        //shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ///Each Child is a different category with GestureDetector to Set the selected item

          GestureDetector(
            child: Category(
              category: 'All',
              enabled: (selection == 0) ? true : false,
            ),
            onTap: () {
              setState(() {
                selection = 0;
              });
            },
          ),
          GestureDetector(
            child: Category(
              category: 'Grocery',
              enabled: (selection == 1) ? true : false,
            ),
            onTap: () {
              setState(() {
                selection = 1;
              });
            },
          ),
          GestureDetector(
            child: Category(
              category: 'Food',
              enabled: (selection == 2) ? true : false,
            ),
            onTap: () {
              setState(() {
                selection = 2;
              });
            },
          ),
          GestureDetector(
            child: Category(
              category: 'Fruits and Vegetables',
              enabled: (selection == 3) ? true : false,
            ),
            onTap: () {
              setState(() {
                selection = 3;
              });
            },
          ),
          GestureDetector(
            child: Category(
              category: 'Electronics',
              enabled: (selection == 4) ? true : false,
            ),
            onTap: () {
              setState(() {
                selection = 4;
              });
            },
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final bool enabled;
  final String? category;

  const Category({
    Key? key,
    this.enabled = false,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color:
              enabled ? kSecondarySearchWidgetColor : kPrimarySearchWidgetColor,
        ),
        child: Center(child: Text(category!)),
      ),
    );
  }
}
