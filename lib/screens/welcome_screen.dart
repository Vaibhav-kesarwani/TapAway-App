import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:uhack_app/screens/user_authentication/provider/auth_provider.dart';
import 'package:uhack_app/screens/user_authentication/user_auth_screen/register_screen.dart';
import 'package:uhack_app/screens/user_authentication/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigateToHomeScreen(BuildContext context) async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    await ap.getDataFromSP().whenComplete(
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }

  void navigateToRegisterScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image1.png",
                  height: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Never a better time than now to start.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: "Get started",
                    onPressed: () async {
                      final ap = Provider.of<AuthProvider>(context, listen: false);
                      if (ap.isSignedIn == true) {
                        navigateToHomeScreen(context);
                      } else {
                        navigateToRegisterScreen(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
