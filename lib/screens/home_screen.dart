import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';
import 'package:uhack_app/screens/about_us_screen/about_us_screen.dart';
import 'package:uhack_app/screens/alert_screen/alert_screen.dart';
import 'package:uhack_app/screens/custom_drawer.dart';
import 'package:uhack_app/screens/emergency_contacts_screen/emergency_contacts_screen.dart';
import 'package:uhack_app/screens/map_screen/map_screen.dart';
import 'package:uhack_app/screens/safety_tips_screen/views/safety_tips_screen.dart';
import 'package:uhack_app/screens/user_authentication/provider/auth_provider.dart';
import 'package:uhack_app/screens/user_authentication/utils/utils.dart';
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
    // ignore: unused_local_variable
    final ap = Provider.of<AuthProvider>(context, listen: false);

    final GlobalKey<ScaffoldState> drawerscaffoldkey =
        GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        shadowColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 143, 134),
        centerTitle: true,
        title: const Text(
          "tapAway",
          style: TextStyle(
            fontSize: 30,
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
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.notifications_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlertScreen(),
                  ),
                  (route) => false);
            },
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
                      blurRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 1, 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(100), // Make it a circle
                    onLongPress: () async {
                      showSnackBar(context, "Your message is sent");

                      // Fetch the emergency contact data
                      EmergencyContactModel? emergencyContactData =
                          await getEmergencyContactData();

                      if (emergencyContactData != null) {
                        // Get the primary emergency number
                        String primaryEmergencyNumber =
                            emergencyContactData.primaryEmergencyNumber;

                        List<String> secondaryEmergencyNumber =
                            emergencyContactData.emergencyNumbers;

                        await FlutterPhoneDirectCaller.callNumber(
                            primaryEmergencyNumber);

                        // Send SMS to the primary emergency number
                        await _getUserLocationAndSendSms(
                          primaryEmergencyNumber,
                        );

                        // Send SMS to secondary emergency numbers
                        for (String phoneNumber in secondaryEmergencyNumber) {
                          await _getUserLocationAndSendSms(phoneNumber);
                        }
                      } else {
                        // Handle the case where no emergency contact data is available.
                      }
                    },
                    child: const Center(
                      child: Text(
                        "SOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 62,
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
                    color: const Color.fromARGB(255, 55, 143, 134),
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
                    color: const Color.fromARGB(255, 55, 143, 134),
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
                    color: const Color.fromARGB(255, 55, 143, 134),
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
                    color: const Color.fromARGB(255, 55, 143, 134),
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
                        builder: (context) => const AboutUsScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 55, 143, 134),
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

  Future<EmergencyContactModel?> getEmergencyContactData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('emergencyContacts').get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      return EmergencyContactModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
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
          'Your acquaintance is in dangerous situation, \nhttps://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

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
