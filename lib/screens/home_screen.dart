import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final PermissionStatus status =
        await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      // Permission granted, you can now access the location.
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> drawerscaffoldkey =
        GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shadowColor: Colors.green.shade600,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.purple.shade300,
        centerTitle: true,
        title: const Text(
          "My App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (drawerscaffoldkey.currentState!.isDrawerOpen) {
              Navigator.pop(context);
            } else {
              drawerscaffoldkey.currentState?.openDrawer();
            }
          },
          icon: const Icon(Icons.menu_rounded),
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {},
          ),
        ],
      ),
      key: drawerscaffoldkey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.lightGreen[100],
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(90),
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.redAccent,
                ),
                child: Material(
                  color: Colors
                      .transparent, // Set the background color to transparent
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(100), // Make it a circle
                    onLongPress: () {
                      // Handle tap here if needed
                      FlutterPhoneDirectCaller.callNumber('7784050116');
                      _getUserLocationAndSendSms("7784050116");
                      _getUserLocationAndSendSms("9219388303");
                      _getUserLocationAndSendSms("7985668749");
                      _getUserLocationAndSendSms("8896067454");
                      _getUserLocationAndSendSms("6392127437");
                    },
                    child: const Center(
                      child: Text(
                        "SOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.cloud_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Live Weather",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade100,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getUserLocationAndSendSms(String phoneNumber) async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Access the user's latitude and longitude
      final double latitude = position.latitude;
      final double longitude = position.longitude;

      // Compose the location message
      final String locationMessage =
          'Hello,\nhttps://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      // Send the location via SMS
      telephony.sendSms(
        to: phoneNumber,
        message: locationMessage,
      );
    } catch (e) {
      // Handle any errors that may occur while fetching the location or sending the SMS.
      print("Error sending SMS: $e");
    }
  }
}
