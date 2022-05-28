import 'package:final_year_project/components/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/services/loc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<Position> setLocation() async {
    var temp = await Loc.getCurrentLocation();
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
