import 'package:flutter/material.dart';
import 'package:uhack_app/screens/about_us_screen/developer_screen.dart';
import 'package:uhack_app/screens/home_screen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100),
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover, // You can adjust the fit to your needs
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 350,
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
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tap Away is an app where the users can register themselves and in case of calamity, user just have to press the SOS button due to which the location of the user/victim will be sent to the concerned authorities and their relatives and friends.\n\nOur services will reach at the site as soon as possible to provide aid to the victim and ensure his safety beacuse your safety is our number one priority.\n\nOur vision is to save as many people as we can because life is precious and we value you.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeveloperScreen(),
                  ),
                  (route) => false);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0.0),
              alignment: Alignment.center,
            ),
            child: const Text(
              '<<<<Know about developer>>>>',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 88, 79, 79),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
