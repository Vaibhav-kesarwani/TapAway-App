import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:uhack_app/screens/on_boarding_screen/models/onboarding_info.dart';
import 'package:uhack_app/screens/welcome_screen.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.offAll(() => const WelcomeScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/image1.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
    OnboardingInfo('assets/image2.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
    OnboardingInfo('assets/image3.png', 'User Authentication',
        'cbidcbicsbc sb ikdbvsvbs bducbdsubsibs hbsjvbs'),
  ];
}
