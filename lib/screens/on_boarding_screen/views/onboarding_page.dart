import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:uhack_app/screens/on_boarding_screen/controllers/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = OnboardingController();

  // Method to check if the onboarding should be displayed
  Future<void> checkIfShowOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showOnboarding = prefs.getBool('showOnboarding') ?? true;

    if (!showOnboarding) {
      // The onboarding should not be shown, navigate to the main app screen.
      // You can use Navigator.pushReplacement for this.
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    }
  }

  // Method to mark the onboarding as completed
  Future<void> markOnboardingAsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showOnboarding', false);
  }

  @override
  void initState() {
    super.initState();
    checkIfShowOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
              itemCount: _controller.onboardingPages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _controller.onboardingPages[index].imageAsset,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        _controller.onboardingPages[index].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: Text(
                          _controller.onboardingPages[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: List.generate(
                  _controller.onboardingPages.length,
                  (index) => Obx(
                    () {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _controller.selectedPageIndex.value == index
                              ? Colors.red
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: _controller.forwardAction,
                child: Obx(
                  () {
                    return Text(_controller.isLastPage ? 'Done' : 'Next');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
