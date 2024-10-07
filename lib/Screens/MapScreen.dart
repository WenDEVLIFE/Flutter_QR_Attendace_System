import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  MapState createState() => MapState();

  const MapScreen({super.key,});
}

class MapState extends State<MapScreen> {
  String _mapType = 'satellite';

  Future<bool> _onBackPressed() async {
    // Handle the back button press
    Navigator.pop(context);
    return false; // Prevent the default back button action
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Location',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF6E738E),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(51.509865, -0.118092),
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: _mapType == 'satellite'
                      ? 'https://api.maptiler.com/tiles/satellite-v2/{z}/{x}/{y}.jpg?key=2FeRdU4DmzOy7sPnsesD'
                      : 'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=2FeRdU4DmzOy7sPnsesD',
                  additionalOptions: const {
                    'key': '2FeRdU4DmzOy7sPnsesD',
                  },
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: DropdownButton<String>(
                value: _mapType,
                items: [
                  DropdownMenuItem(
                    value: 'satellite',
                    onTap: () {
                     Fluttertoast.showToast(
                        msg: 'Satellite Mode',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0
                     );
                    },
                    child: const Text('Satellite'),
                  ),
                  DropdownMenuItem(
                    value: 'street',
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: 'Street Mode',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    child: const Text('Street'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _mapType = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}