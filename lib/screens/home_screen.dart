import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
<<<<<<< HEAD
  final String _phoneNumber = '7784050116';
=======
  final String _phoneNumber = '6393599881';
>>>>>>> 6ae10de69e748c3498443307fc6ff09f8662a339

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
<<<<<<< HEAD
            final _call = 'tel:$_phoneNumber';
            // final _text = 'sms:$_phoneNumberr';
            if (await canLaunch(_call)) {
              await launch(_call);
=======
            // final _call = 'tel:$_phoneNumber';
            final _text = 'sms:$_phoneNumber';
            if (await canLaunch(_text)) {
              await launch(_text);
>>>>>>> 6ae10de69e748c3498443307fc6ff09f8662a339
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
