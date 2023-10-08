import 'package:flutter/material.dart';
import 'package:uhack_app/screens/home_screen.dart';

class DosAndDontsScreen extends StatefulWidget {
  const DosAndDontsScreen({super.key});

  @override
  State<DosAndDontsScreen> createState() => _DosAndDontsScreenState();
}

class _DosAndDontsScreenState extends State<DosAndDontsScreen> {
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
    );
  }
}
