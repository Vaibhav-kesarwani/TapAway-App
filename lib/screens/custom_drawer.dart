import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhack_app/screens/about_us_screen/about_us_screen.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:uhack_app/screens/map_screen/map_screen.dart';
import 'package:uhack_app/screens/settings_screen/setting_screen.dart';
import 'package:uhack_app/screens/user_authentication/provider/auth_provider.dart';
import 'package:uhack_app/screens/welcome_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void navigateToScreen(Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 95, 93, 93),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (ap.isSignedIn && ap.userModel != null) ...[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(ap.userModel!.profilePic),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ap.userModel!.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    ap.userModel!.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Home'),
            onTap: () {
              navigateToScreen(const HomeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_sharp),
            title: const Text('Map'),
            onTap: () {
              navigateToScreen(const MapScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              navigateToScreen(const SettingScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              navigateToScreen(const AboutUsScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: () {
              ap.userSignOut().then((value) {
                navigateToScreen(const WelcomeScreen());
              });
            },
          ),
        ],
      ),
    );
  }
}
