import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadItemFile({
    String? filePath,
    String? fileName,
  }) async {
    File file = File(filePath!);
    try {
      await storage.ref('item_images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> uploadShopFile({
    String? filePath,
    String? fileName,
  }) async {
    File file = File(filePath!);
    try {
      await storage.ref('shop_images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String?> getShopDownloadLink({
    String? filePath,
    String? fileName,
  }) async {
    String? downloadUrl;
    try {
      downloadUrl = await storage.ref('shop_images/$fileName').getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
    return downloadUrl;
  }
}
