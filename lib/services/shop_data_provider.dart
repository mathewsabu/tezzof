import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'data_controller.dart';

class ShopData extends ChangeNotifier {
  QueryDocumentSnapshot? doc;
  QuerySnapshot? itemsDoc;
  List<String?>? categoriesData = [];
  List<Map<String, dynamic>> itemsMap = [];

  QueryDocumentSnapshot? get document => doc;
  QuerySnapshot? get items => itemsDoc;
  List<Map<String, dynamic>> get itemsList => itemsMap;
  List<String?>? get categories => categoriesData;

  Future getShopData(String uid) async {
    doc = await DataController.queryShopData(uid);
    itemsDoc = await DataController.queryItemData(uid);
    print(itemsDoc!.docs.length);

    List<Map<String, dynamic>> tempList = [];

    for (int i = 0; i < itemsDoc!.docs.length; i++) {
      Map<String, dynamic> temp =
          itemsDoc!.docs[i].data() as Map<String, dynamic>;
      tempList.add(temp);
      categoriesData!.add(temp['category']);
      categoriesData = categoriesData!.toSet().toList();
    }

    itemsMap = tempList;

    print(itemsMap.length);
    notifyListeners();
    return true;
  }
}
