import 'package:final_year_project/components/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/add_images.dart';
import 'package:final_year_project/components/string_input_box.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:final_year_project/services/shop_data_provider.dart';
import 'package:final_year_project/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_year_project/components/select_category.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ItemAddScreen extends StatefulWidget {
  const ItemAddScreen({Key? key}) : super(key: key);

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  String? name;
  int? price;
  bool numberError = false;
  bool isloading = false;
  List<XFile>? images = [];

  final Storage storage = Storage();

  final _fireStore = FirebaseFirestore.instance;

  Future<List<String>> uploadImages(List<XFile> l) async {
    List<String> imageLinks = [];
    if (l.isNotEmpty) {
      for (int i = 0; i < l.length; i++) {
        await storage.uploadFile(
            location: 'item_images', fileName: l[i].name, filePath: l[i].path);
        String? downloadLink = await storage.getDownloadLink(
            location: 'item_images', fileName: l[i].name, filePath: l[i].path);
        imageLinks.add(downloadLink!);
      }
      return imageLinks;
    } else {
      return imageLinks;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? shopData =
        context.read<ShopData>().doc!.data() as Map<String, dynamic>;
    List<String>? categories = context.read<ShopData>().categories;
    User? user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: AddImages(
              width: double.infinity,
              height: 200.0,
            ),
          ),
          StringInputBox(
            label: 'Name',
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),

          ///Field to add the Price
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: TextFormField(
              decoration: kTextFieldDecoration.copyWith(labelText: 'Price'),
              onChanged: (value) {
                setState(() {
                  try {
                    price = int.parse(value);
                  } catch (e) {
                    numberError = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Price Invalid!')));
                  }
                });
              },
              keyboardType: TextInputType.number,
            ),
          ),

          SelectCategoryWidget(categories: categories!),

          ///Submit Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () async {
                setState(() {
                  isloading = true;
                });
                List<String> imageLinks = await uploadImages(AddImages.images);
                print(AddImages.images.length);
                AddImages.images = [];

                await _fireStore.collection('itemdata').doc().set({
                  'uid': user!.uid,
                  'name': name,
                  'price': price,
                  'location': shopData['location'],
                  'shop': shopData['buisnessName'],
                  'category': SelectCategoryWidget.finalValue,
                  'image': imageLinks,
                  'offer': null,
                }, SetOptions(merge: true));

                // ignore: use_build_context_synchronously
                Navigator.pop(context);

                setState(() {
                  isloading = false;
                });
              },
              style: kButtonStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: isloading
                    ? const CircularProgressIndicator()
                    : kSubmitButtonChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
