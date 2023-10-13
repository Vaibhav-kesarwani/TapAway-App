import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhack_app/screens/about_us_screen/about_us_screen.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:uhack_app/screens/user_authentication/provider/auth_provider.dart';
import 'package:uhack_app/screens/welcome_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      ap.userModel.profilePic), // Your user's profile picture
                ),
                const SizedBox(height: 10),
                Text(
                  ap.userModel.name, // Your user's name
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  ap.userModel.email, // Your user's email
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Home'),
            onTap: () {
              // Handle the Home action
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle the Settings action
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle the Settings action
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                  (route) => false);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: () {
              // Handle the Log Out action
              ap.userSignOut().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false),
                  );
            },
          ),
        ],
      ),
    );
  }
}
