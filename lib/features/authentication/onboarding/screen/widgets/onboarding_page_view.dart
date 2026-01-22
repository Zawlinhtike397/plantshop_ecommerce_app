import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/screen/widgets/onboarding_page_component.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key, required PageController pageController})
    : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        //#1
        OnBoardingPageComponent(
          onBoardingTitle: AppText.onBoardingTitle1,
          onBoardingSubTitle: AppText.onBoardingSubTitle1,
          image: ImageStrings.onBoardingAnimation1,
        ),
        OnBoardingPageComponent(
          onBoardingTitle: AppText.onBoardingTitle2,
          onBoardingSubTitle: AppText.onBoardingSubTitle2,
          image: ImageStrings.onBoardingAnimation2,
        ),
        OnBoardingPageComponent(
          onBoardingTitle: AppText.onBoardingTitle3,
          onBoardingSubTitle: AppText.onBoardingSubTitle3,
          image: ImageStrings.onBoardingAnimation3,
        ),
      ],
    );
  }
}
