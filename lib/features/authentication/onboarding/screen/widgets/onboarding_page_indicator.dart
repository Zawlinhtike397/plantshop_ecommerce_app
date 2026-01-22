import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPageIndicator extends StatelessWidget {
  const OnBoardingPageIndicator({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.2),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: 3,
        effect: const WormEffect(dotWidth: 10, dotHeight: 10),
      ),
    );
  }
}
