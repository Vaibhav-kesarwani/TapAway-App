import 'package:flutter/material.dart';
import 'package:uhack_app/screens/home_screen.dart';
import 'package:uhack_app/screens/safety_tips_screen/models/onboarding_info.dart';

class SafetyTipsScreen extends StatefulWidget {
  const SafetyTipsScreen({super.key});

  @override
  State<SafetyTipsScreen> createState() => _SafetyTipsScreenState();
}

class _SafetyTipsScreenState extends State<SafetyTipsScreen> {
  int selectedPageIndex = 0;
  PageController pageController = PageController();
  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo(
      'assets/on1.png',
      "Don't press the button unnecessarily!",
      "Use only in emergency conditions otherwise you'll be penalized.",
    ),
    OnboardingInfo(
      'assets/on2.png',
      'Attentive Person!',
      'Your emergency contact should be attentive in picking the calls.',
    ),
    OnboardingInfo(
      'assets/on3.png',
      'Active GPS!',
      "Your phone's GPS should be always turned on.",
    ),
    OnboardingInfo(
      'assets/on4.png',
      'Long Press!',
      'Long press the button in case of an emergency.',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void forwardAction() {
    if (selectedPageIndex == onboardingPages.length - 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedPageIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedPageIndex = index;
                });
              },
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(onboardingPages[index].imageAsset),
                      const SizedBox(height: 32),
                      Text(
                        onboardingPages[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          onboardingPages[index].description,
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
                  onboardingPages.length,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: selectedPageIndex == index
                            ? Colors.red
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: forwardAction,
                child: Text(selectedPageIndex == onboardingPages.length - 1
                    ? 'Done'
                    : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
