import 'package:flutter/material.dart';
import 'package:uhack_app/screens/home_screen.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Alert',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.purple,
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
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40),
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: Colors.black,
            ),
            child: Image.asset(
              'assets/alert.png',
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }
}
