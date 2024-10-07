import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  MapState createState() => MapState();

  const MapScreen({super.key,});
}

class MapState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapTiler in Flutter'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.509865, -0.118092),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=YOUR_MAPTILER_API_KEY',
            additionalOptions: const {
              'key': 'eOaz0CKREUJuyTgP9s4D',
            },
          ),
        ],
      ),
    );
  }
}