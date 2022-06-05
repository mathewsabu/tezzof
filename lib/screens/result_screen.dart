import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:final_year_project/components/item_card.dart';
import 'package:final_year_project/components/category_selector.dart';
import 'package:final_year_project/services/loc.dart';
import 'package:provider/provider.dart';
import 'package:final_year_project/services/data_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, this.query}) : super(key: key);
  final String? query;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isLoading = false;
  List<Map<String, dynamic>> result = [];
  String? query;
  @override
  void initState() {
    query = widget.query;
    getthedata();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  void getthedata() async {
    setState(() {
      isLoading = true;
    });
    var position = context.read<Loc>().currentPosition;
    List<Map<String, dynamic>> temp =
        await DataController.queryData('itemdata', query!, position!);
    print(temp);
    setState(() {
      result.addAll(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: CategorySelector()),
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCard(
                            name: result[index]['name'],
                            shopName: result[index]['shopName'],
                            distance: result[index]['distance'],
                            price: result[index]['price'].toString(),
                            offer: result[index]['offer'],
                            imageUrl: result[index]['image'][0].toString(),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
