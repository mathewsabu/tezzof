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

    ///Get all docs with Query
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      Map<String, dynamic> temp =
          snapshot.docs[i].data() as Map<String, dynamic>;
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

  Future queryOfferData(String collection, String queryString) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('offer', isGreaterThanOrEqualTo: 0)
        .orderBy('offer', descending: true)
        .get();

    return snapshot;
  }
}
