import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/screen/widgets/onboarding_arrow_button.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/screen/widgets/onboarding_page_indicator.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/screen/widgets/onboarding_page_view.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/screen/widgets/onboarding_skip_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              OnboardingPageView(pageController: _pageController),
              OnBoardingPageIndicator(pageController: _pageController),

              OnBoardingArrowButton(pageController: _pageController),

              OnBoardingSkipText(),
            ],
          ),
        ),
      ),
    );
  }
}
