import 'package:final_year_project/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/constants.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:final_year_project/services/data_controller.dart';
import 'package:get/get.dart';
import 'package:final_year_project/components/category_selector.dart';
import 'package:final_year_project/components/item_card.dart';
import 'package:final_year_project/services/loc.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'result_screen.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'search_screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  bool isCompleated = false;

  ///List of autocomplete strings fetced from firebase
  late List<String> autoCompleteData;
  List<Map<String, dynamic>> result = [];
  late TextEditingController controller;
  String? query;

  String? state;

  @override
  void initState() {
    super.initState();
    getAutoCompleteData();
  }

  ///function to get autocomplete Strings. This function is called in the init state
  Future getAutoCompleteData() async {
    var temp = await DataController.getData('itemdata');
    setState(() {
      autoCompleteData = temp;
    });
  }

  void onComplete() {
    Navigator.push<void>(context,
        MaterialPageRoute(builder: (BuildContext context) => ResultScreen(query: query,)));
    setState(() {
      isCompleated = true;
      isLoading = false;
    });
  }

  void onSubmit(String? value) {}

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    ///children of column
    children = [
      ///Custom Autocomplete Widget

//      if (isCompleated == false)
      Autocomplete(
        optionsMaxHeight: 200,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          } else {
            return autoCompleteData.where((word) => word
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          }
        },
        optionsViewBuilder: (context, Function(String) onSelected, options) {
          return Material(
            elevation: 4,
            type: MaterialType.transparency,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);

                return ListTile(
                  // title: Text(option.toString()),
                  title: SubstringHighlight(
                    text: option.toString(),
                    term: controller.text,
                    textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  //subtitle: const Text("This is subtitle"),
                  onTap: () {
                    onSelected(option.toString());
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: options.length,
            ),
          );
        },
        onSelected: (selectedString) {
          setState(() {
                        query = selectedString.toString();
                        print(selectedString);
                      });
          print(selectedString);
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          this.controller = controller;

          return Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
                color: kPrimarySearchWidgetColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                        print(value);
                      });
                    },
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onComplete,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isCompleated = true;
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          );
        },
      ),

      ///End of the damn AutoComplete
    ];
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
      ),
    );
  }
}
