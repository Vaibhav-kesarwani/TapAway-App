import 'package:flutter/material.dart';
import 'package:uhack_app/screens/about_us_screen/models/about_us_info.dart';
import 'package:uhack_app/screens/home_screen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  int selectedPageIndex = 0;
  PageController pageController = PageController();
  List<AboutUsInfo> onboardingPages = [
    AboutUsInfo(
      'assets/on1.png',
      "Don't press the button unnecessarily!",
      "Our technoloy platform connects several nearby rescue agencies, hospitals and police stations and also share the location of the victim at the time of calamity so that necessary aid can be provided to those who",
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
