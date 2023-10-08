import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uhack_app/screens/home_screen.dart';

const LatLng currentLocation = LatLng(25.1193, 55.3773);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  // ignore: prefer_final_fields
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          addMarker('test', currentLocation);
        },
        markers: _markers.values.toSet(),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Title of the place',
        snippet: 'Some description of the place',
      ),
    );

    _markers[id] = marker;
    setState(() {});
  }
}
