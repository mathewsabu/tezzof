import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/services/authentication_service.dart';
import 'package:final_year_project/services/shop_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'item_add_screen.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/components/item_card_shop.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  User? firebaseUser;

  @override
  void initState() {
    firebaseUser = context.read<User?>();
    fetchData(context);
    super.initState();
  }

  Future fetchData(BuildContext context) async {
    await context.read<ShopData>().getShopData(firebaseUser!.uid);
  }

  /// the shop data is fetched fro mthe data_controller class

  @override
  Widget build(BuildContext context) {
    const kContainerDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(71, 0, 0, 0),
          offset: Offset(0, 4.0), //(x,y)
          blurRadius: 6.0,
        )
      ],
    );

    return FutureBuilder(
        future: context.read<ShopData>().getShopData(firebaseUser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            QueryDocumentSnapshot? shopDataDoc =
                context.watch<ShopData>().document;
            Map<String, dynamic> shopDataMap =
                shopDataDoc!.data() as Map<String, dynamic>;
            List<Map<String, dynamic>> itemsData =
                context.watch<ShopData>().itemsList;
            List<String?>? categories = context.read<ShopData>().categories;
            print(shopDataMap['buisnessName']);

            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      shopDataMap['buisnessName'],
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: kScaffoldColor,
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(shopDataMap['images'][0]),
                              fit: BoxFit.cover),
                          // borderRadius: const BorderRadius.only(
                          //     bottomLeft: Radius.circular(40),
                          //     bottomRight: Radius.circular(40)),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          getChildren(categories!, itemsData)))
                ],
              ),
              floatingActionButton: SizedBox(
                width: 70,
                height: 70,
                child: FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ItemAddScreen()));
                    }),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

List<Widget> getChildren(
    List<String?> categories, List<Map<String, dynamic>> itemsData) {
  List<Widget> children = [];
  print(categories);
  for (int i = 0; i < itemsData.length; i++) print(itemsData[i]['category']);

  for (int i = 0; i < categories.length; i++) {
    children.add(Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 40, left: 50.0),
      child: Text(
        categories[i]!,
        style: const TextStyle(
          fontFamily: 'poppins',
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));

    children.add(const Divider(
      height: 0,
      indent: 50.0,
      endIndent: 50.0,
      thickness: 1.0,
    ));

    for (int j = 0; j < itemsData.length; j++) {
      if (itemsData[j]['category'] == categories[i]) {
        children.add(
          ShopItemCard(
            name: itemsData[j]['name'],
            price: itemsData[j]['price'].toString(),
            offer: itemsData[j]['offer'],
            imageUrl: itemsData[j]['image'],
          ),
        );
      }
    }
  }
  return children;
}
