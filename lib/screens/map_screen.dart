import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/services/loc.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  static String id = 'map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Marker? selectedPosition;

  /// Marker
  Position? position;
  LatLng currentPos =
      const LatLng(9.54, 76.81); // Current position with default values

  /// function to get the current location

  void getLocation() async {

    await context.read<Loc>().getCurrentLocation();

    ///function to check for permission
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPos = LatLng(position!.latitude, position!.longitude);
      selectedPosition = Marker(
        markerId: const MarkerId('selected'),
        infoWindow: const InfoWindow(title: 'Your Location'),
        position: currentPos,
      );
    });
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ///Google map Widget for generating the Map!
                  GoogleMap(
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    markers: {
                      if (selectedPosition != null) selectedPosition!,
                    },
                    onMapCreated: (controller) => _controller = controller,
                    initialCameraPosition: CameraPosition(
                      target: currentPos,
                      zoom: 15.0,
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20.0),
                          child: TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                                fillColor: Colors.white,
                                labelText: 'Business Name'),
                            onChanged: (name) {},
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 50.0,
                        ),
                        onTap: () {
                          print('submitted');
                        },
                      ),
                    ],
                  ),

                  // Container(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  //     child: TextFormField(
                  //       decoration:
                  //           kTextFieldDecoration.copyWith(labelText: 'Business Name'),
                  //       onChanged: (name) {},
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, currentPos.toJson().toString());
              },
              style: kButtonStyle,
              child: kSubmitButtonChild,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.gps_fixed),
          onPressed: () {
            getLocation();
            _goToTheLake();
          },
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    await _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentPos,
          zoom: 16.0,
        ),
      ),
    );
  }
}
