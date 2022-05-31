import 'package:flutter/material.dart';
import 'package:final_year_project/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          color: kPrimarySearchWidgetColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: [
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          )),
          IconButton(
              onPressed: () {
                print('hai');
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}
