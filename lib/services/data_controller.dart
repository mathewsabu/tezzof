import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DataController extends GetxController {
  static Future getData(String collection) async {
    List<String> names = [];
    List<String> uniqueNames = [];
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      Map temp = snapshot.docs[i].data() as Map<String, dynamic>;
      String name = temp['name'];
      names.add(name);
    }

    uniqueNames = names.toSet().toList();

    print(uniqueNames);

    return names;
  }

  static Future<List<Map<String, dynamic>>> queryData(
      String collection, String queryString, Position postition) async {
    print('function called');
    List<Map<String, dynamic>> result = [];
    print('Print Is WOrkig!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    print(queryString);

    ///Get all docs with Query
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    List resultDocs = snapshot.docs
        .where((QueryDocumentSnapshot<Object?> element) => element['name']
            .toString()
            .toLowerCase()
            .contains(queryString.toLowerCase()))
        .toList();

    for (int i = 0; i < resultDocs.length; i++) {
      Map<String, dynamic> temp = resultDocs[i].data() as Map<String, dynamic>;
      GeoPoint? shopPosition = temp['location'];
      var shopName = temp['shop'];
      var distance = Geolocator.distanceBetween(
        postition.latitude,
        postition.longitude,
        shopPosition!.latitude,
        shopPosition.longitude,
      );
      temp.addAll({'distance': distance, 'shopName': shopName});
      result.add(temp);
    }

    result.sort(((a, b) => a['distance'].compareTo(b['distance'])));
    print(result);
    return result;
  }

  static Future queryItemData(String uid) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('itemdata')
        .where('uid', isEqualTo: uid)
        .get();

    return snapshot;
  }

  static Future queryShopData(String uid) async {
    print(uid);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('shopdata')
        .where('uid', isEqualTo: uid)
        .get();
    var temp = snapshot.docs.first.data();
    print(temp);

    return snapshot.docs.first;
  }
}
