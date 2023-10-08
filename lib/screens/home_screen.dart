import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:uhack_app/screens/about_us_screen/about_us_screen.dart';
import 'package:uhack_app/screens/dos_and_donts_screen/dos_and_donts_screen.dart';
import 'package:uhack_app/screens/emergency_contacts_screen/emergency_contacts_screen.dart';
import 'package:uhack_app/screens/map_screen/map_screen.dart';
import 'package:uhack_app/screens/my_header_drawer.dart';
import 'package:uhack_app/screens/safety_tips_screen/safety_tips_screen.dart';
import 'package:uhack_app/screens/wether_screen/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Telephony telephony = Telephony.instance;

  var currentPage = DrawerSections.dashboard;

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

    // ignore: unused_local_variable
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = HomeScreen(key: UniqueKey());
    } else if (currentPage == DrawerSections.contacts) {
      // container = ContactScreen();
    } else if (currentPage == DrawerSections.alert) {
      // container = AlertScreen();
    } else if (currentPage == DrawerSections.notes) {
      // container = NoteScreen();
    } else if (currentPage == DrawerSections.settings) {
      // container = SettingsScreen();
    } else if (currentPage == DrawerSections.privacy_policy) {
      // container = PrivacyPolicyScreen();
    } else if (currentPage == DrawerSections.send_feedback) {
      // container = SendFeedbackScreen();
    }

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
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
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
          'Hello,\nhttps://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      // Send the location via SMS
      telephony.sendSms(
        to: phoneNumber,
        message: locationMessage,
      );
    } catch (e) {
      // Handle any errors that may occur while fetching the location or sending the SMS.
    }
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "Alert", Icons.notification_important_rounded,
              currentPage == DrawerSections.alert ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          const Divider(),
          menuItem(5, "Settings", Icons.settings,
              currentPage == DrawerSections.settings ? true : false),
          const Divider(),
          menuItem(6, "Privacy Policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(7, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.alert;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 7) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  alert,
  notes,
  settings,
  privacy_policy,
  send_feedback,
}
