// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_year_project/components/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/services/loc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:final_year_project/constants.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:provider/provider.dart';
import 'package:final_year_project/components/search_bar.dart';
import 'package:final_year_project/components/category_selector.dart';
import 'package:final_year_project/screens/search_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  static String? id = 'customer_home_screen';

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  Position? position;
  double? latitude = 27.6648;
  double? longitude = 81.5158;

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  Future<Position?> setLocation() async {
    var temp = context.read<Loc>().getCurrentLocation();
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: LocationWidget(
                latitude: snapshot.data.latitude,
                longitude: snapshot.data.longitude,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: kPrimarySearchWidgetColor),
                        child: Row(
                          children: [
                            Expanded(child: Text('Search')),
                            Icon(Icons.search)
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                    ),
                  ),
                  CategorySelector(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Top Offers Near You',
                    style: kDefaultTextStyle,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
