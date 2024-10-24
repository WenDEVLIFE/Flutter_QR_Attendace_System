import 'package:attendance_qr_system/Key/ApiKey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class MapScreen extends StatefulWidget {
  @override
  MapState createState() => MapState();

  const MapScreen({super.key, required this.data});

  final Map<String, dynamic> data;
}

class MapState extends State<MapScreen> {
  String _mapType = 'satellite';
  String Time = '';
  String Date = '';
  String FullName = '';
  String ImageURL = '';
  String Status = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String api = ApiKey.key;
  late Map<String, dynamic> data;
  bool _showPopup = false;
  Offset _markerPosition = Offset.zero;

  Future<bool> _onBackPressed() async {
    Navigator.pop(context);
    return false;
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    latitude = data['latitude'];
    longitude = data['longitude'];
    Time = data['Time'];
    Date = data['Date'];
    Status = data['Status'];
    showProgressDialog();
    LoadData();
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
                center: LatLng(latitude, longitude),
                zoom: 13.0,
                onTap: (_, __) => setState(() => _showPopup = false),
              ),
              children: [
                TileLayer(
                  urlTemplate: _mapType == 'satellite'
                      ? 'https://api.maptiler.com/tiles/satellite-v2/{z}/{x}/{y}.jpg?key=$api'
                      : 'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=$api',
                  additionalOptions: {
                    'key': api,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(latitude, longitude),
                      builder: (ctx) => GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            _markerPosition = details.globalPosition;
                            _showPopup = true;
                          });
                        },
                        child: const Column(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('Assets/user.png') as ImageProvider, // Replace with your image path
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            if (_showPopup)
              Positioned(
                left: _markerPosition.dx - 40, // Adjust the horizontal position
                top: _markerPosition.dy - 300, // Adjust the vertical position to be above the marker
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Latitude: $latitude'),
                        Text('Longitude: $longitude'),
                        Text('Name: $FullName'),
                        Text('Time: $Time'),
                        Text('Date: $Date'),
                        Text('Status: $Status'),
                      ],
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 10,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: DropdownButton<String>(
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
                              fontSize: 16.0,
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
                              fontSize: 16.0,
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
      await Future.delayed(const Duration(milliseconds: 50));
      pd.update(value: loading);
    }

    pd.close();
  }

  Future<void> LoadData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users')
          .where("ID", isEqualTo: data['userID'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var FullNameData = doc['Full Name'];
        var Image = doc['imageURL'];

        setState(() {
          FullName = FullNameData;
          ImageURL = Image;
        });
      } else {
        Fluttertoast.showToast(
          msg: 'No data found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}