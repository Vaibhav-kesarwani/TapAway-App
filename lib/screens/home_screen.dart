import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _phoneNumber = '6393599881';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            // final _call = 'tel:$_phoneNumber';
            final _text = 'sms:$_phoneNumber';
            if (await canLaunch(_text)) {
              await launch(_text);
            }
          },
          color: Colors.blue,
          child: const Text(
            'Text Me',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
