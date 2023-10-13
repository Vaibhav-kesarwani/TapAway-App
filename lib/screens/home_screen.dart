import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:uhack_app/screens/about_us_screen/about_us_screen.dart';
import 'package:uhack_app/screens/custom_drawer.dart';
import 'package:uhack_app/screens/dos_and_donts_screen/dos_and_donts_screen.dart';
import 'package:uhack_app/screens/emergency_contacts_screen/emergency_contacts_screen.dart';
import 'package:uhack_app/screens/map_screen/map_screen.dart';
import 'package:uhack_app/screens/safety_tips_screen/safety_tips_screen.dart';
import 'package:uhack_app/screens/wether_screen/weather_screen.dart';

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
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.phone,
      Permission.sms,
      // Add more permissions as needed
    ].request();

    // Check the status of each permission
    if (statuses[Permission.locationWhenInUse]!.isGranted) {
      // Location permission granted, you can now access the location.
    }

    if (statuses[Permission.camera]!.isGranted) {
      // Camera permission granted, you can now use the camera.
    }

    if (statuses[Permission.microphone]!.isGranted) {
      // Microphone permission granted, you can now access the microphone.
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> drawerscaffoldkey =
        GlobalKey<ScaffoldState>();

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 67, 42, 42),
      appBar: AppBar(
        toolbarHeight: 90,
        shadowColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.purple,
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
      drawer: const CustomDrawer(),
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
                      // color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 1, 1),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.wb_cloudy_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Live \nWeather",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmergencyContactScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.call_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Emergency \nContacts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.location_on_sharp,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Map",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SafetyTipsScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.shield_sharp,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Safety \nTips",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DosAndDontsScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.library_books_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Do's and \nDon't",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.info_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "About \nus",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
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
          'Your acquaintance is in an loathsome situation, here is their current location https://www.google.com/maps/search/?api=1&query=$latitude,$longitude and the respective rescue agencies are on their way for their rescue.\nआपका परिचित एक घृणित स्थिति में है, यहां उनका वर्तमान स्थान है और संबंधित बचाव एजेंसियां ​​उनके बचाव के लिए काम कर रही हैं।\nhttps://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      // Send the location via SMS
      telephony.sendSms(
        to: phoneNumber,
        message: locationMessage,
      );
    } catch (e) {
      // Handle any errors that may occur while fetching the location or sending the SMS.
    }
  }
}
