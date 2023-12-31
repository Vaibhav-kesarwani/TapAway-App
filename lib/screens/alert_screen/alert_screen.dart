import 'package:flutter/material.dart';
import 'package:uhack_app/screens/home_screen.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Alert',
        style: TextStyle(
          color: Colors.white,
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
      toolbarHeight: 90,
      backgroundColor: const Color.fromARGB(255, 55, 143, 134),
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
    );
  }

  Container buildAlertContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 0, 255, 234),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/alert.png',
            alignment: Alignment.topCenter,
          ),
          const Text(
            "Emergency!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "The Alert message will be displayed here in case of any emergency.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAlertContainer(),
        ],
      ),
    );
  }
}
