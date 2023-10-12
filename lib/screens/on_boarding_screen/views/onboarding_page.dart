import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhack_app/screens/on_boarding_screen/models/onboarding_info.dart';
import 'package:uhack_app/screens/welcome_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int selectedPageIndex = 0;
  PageController pageController = PageController();
  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/image1.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
    OnboardingInfo('assets/image2.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
    OnboardingInfo('assets/image3.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> checkIfShowOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showOnboarding = prefs.getBool('showOnboarding') ?? true;

    if (!showOnboarding) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
    }
  }

  Future<void> markOnboardingAsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showOnboarding', false);
  }

  @override
  void initState() {
    super.initState();
    checkIfShowOnboarding();
  }

  void forwardAction() {
    if (selectedPageIndex == onboardingPages.length - 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
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
