import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  Circle? _userCircle;
  Circle? _transparentBlueCircle; // Added transparent blue circle
  TextEditingController _searchController = TextEditingController();
  Polyline? _routePolyline;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng userLocation = LatLng(position.latitude, position.longitude);

      if (_userCircle == null) {
        // Create a circle for the user's location if it doesn't exist
        _userCircle = Circle(
          circleId: const CircleId('userCircle'),
          center: userLocation,
          radius: 20, // Initial radius (adjust as needed)
          fillColor: const Color.fromARGB(
              255, 8, 107, 187), // Purple circle with opacity
          strokeColor: Colors.purple, // Border color
          strokeWidth: 2, // Border width
        );

        // Create a transparent blue circle with a 10 km radius
        _transparentBlueCircle = Circle(
          circleId: const CircleId('transparentBlueCircle'),
          center: userLocation,
          radius: 100, // 10 km in meters
          fillColor:
              const Color.fromARGB(128, 0, 0, 255), // Transparent blue circle
          strokeColor: Colors.blue, // Border color
          strokeWidth: 2, // Border width
        );
      } else {
        // Update the existing user circle's position
        _userCircle = _userCircle!.copyWith(centerParam: userLocation);
        _transparentBlueCircle =
            _transparentBlueCircle!.copyWith(centerParam: userLocation);
      }

      // Move the camera to the user's location
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, 15),
      );

      setState(() {}); // Trigger a rebuild to update the circle positions
    } catch (e) {
      print("Error getting user's location: $e");
    }
  }

  Future<void> _fetchRoute(LatLng origin, LatLng destination) async {
    const apiKey = 'AIzaSyAXBWwV59Q5OlaUZ1TQs-j6YXgp_7cqHPA';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'];

      if (routes.isNotEmpty) {
        final points = routes[0]['overview_polyline']['points'];
        final list = decodePoly(points);

        setState(() {
          _routePolyline = Polyline(
            polylineId: PolylineId('route'),
            points: list,
            color: Colors.blue,
            width: 5,
          );
        });

        _fitRouteToBounds(list);
      }
    } else {
      print('Error fetching route: ${response.statusCode}');
    }
  }

  List<LatLng> decodePoly(String encoded) {
    var len = encoded.length;
    var index = 0;
    List<LatLng> poly = [];
    var lat = 0;
    var lng = 0;

    while (index < len) {
      var b;
      var shift = 0;
      var result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      var latitude = lat / 1e5;
      var longitude = lng / 1e5;

      poly.add(LatLng(latitude, longitude));
    }

    return poly;
  }

  void _searchLocation() async {
    final query = _searchController.text;

    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final userLocation = locations[0];
        LatLng userLatLng = LatLng(
          userLocation.latitude,
          userLocation.longitude,
        );

        _fetchRoute(
          LatLng(_userCircle!.center.latitude, _userCircle!.center.longitude),
          userLatLng,
        );

        // Move the camera to the searched location
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(userLatLng, 15),
        );
      } else {
        print('No results found for the given location.');
      }
    } catch (e) {
      print('Error searching for location: $e');
    }
  }

  void _fitRouteToBounds(List<LatLng> points) {
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (LatLng point in points) {
      if (point.latitude < minLat) {
        minLat = point.latitude;
      }
      if (point.latitude > maxLat) {
        maxLat = point.latitude;
      }
      if (point.longitude < minLng) {
        minLng = point.longitude;
      }
      if (point.longitude > maxLng) {
        maxLng = point.longitude;
      }
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        50, // Padding
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 55, 143, 134),
        centerTitle: true,
        title: const Text(
          'Map',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2.0,
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
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for a location...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: _searchLocation,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12), // Add padding inside the text field
              border: OutlineInputBorder(
                // Add border styling
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.5), // Border color
                  width: 1, // Border width
                ),
              ),
              focusedBorder: OutlineInputBorder(
                // Add border styling when focused
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.purple, // Focused border color
                  width: 2, // Focused border width
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0), // Initial camera position (dummy)
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              circles: _userCircle != null
                  ? <Circle>{_userCircle!, _transparentBlueCircle!}
                  : {}, // Include both circles
              polylines:
                  _routePolyline != null ? <Polyline>{_routePolyline!} : {},
            ),
          ),
        ],
      ),
    );
  }
}
