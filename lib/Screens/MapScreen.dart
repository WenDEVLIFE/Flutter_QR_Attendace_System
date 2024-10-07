import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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
  void initState() {
    super.initState();
    showProgressDialog();
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
              child:  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
              child: Container(
              width: 200,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
              ), child: DropdownButton<String>(
                value: _mapType,
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    showProgressDialog();
                    _mapType = value!;
                  });
                },
              ),
            ),

        ),
      ),
    ),
          ],
        ),
      ),
    );

  }
  Future<void> showProgressDialog() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100,
      msg: 'Loading Terrain...',
      backgroundColor: const Color(0xFF6E738E),
      progressBgColor: Colors.transparent,
      progressValueColor: Colors.blue,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );

    for (int loading = 0; loading <= 100; loading++) {
      await Future.delayed(const Duration(milliseconds: 50)); // Simulate some work
      pd.update(value: loading);
    }

    pd.close();
  }
}