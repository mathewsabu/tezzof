import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:final_year_project/services/network_helper.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget(
      {Key? key, @required this.latitude, @required this.longitude})
      : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();

  final double? latitude;
  final double? longitude;
}

class _LocationWidgetState extends State<LocationWidget> {
  String? addr1 = '';
  String? addr2 = '';
  String apiKey = 'AIzaSyCBqUqnXJvXXRxdDrVCsb-1lyDSZ6nUdnA';
  var result;

  static const TextStyle kFeatureText = TextStyle(
    color: Color.fromARGB(255, 194, 61, 51),
    fontSize: 20.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle kSubText = TextStyle(
      fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.w200);

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() async {
    var address;
    try {
      result = await NetworkHelper.getData(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${widget.latitude},${widget.longitude}&key=$apiKey');
      print(result);
      print(widget.latitude);
      print(widget.longitude);
    } catch (e) {
      print(e);
    }
    setState(() {
      addr1 = result["results"][0]["address_components"][1]["long_name"];
      addr2 = result["results"][0]["formatted_address"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Icon(
            Icons.location_on_sharp,
            color: Color.fromARGB(255, 194, 61, 51),
            size: 40.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addr1!,
                style: kFeatureText,
                textAlign: TextAlign.left,
              ),
              Text(
                addr2!,
                style: kSubText,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ],
      ),
    );
  }
}
