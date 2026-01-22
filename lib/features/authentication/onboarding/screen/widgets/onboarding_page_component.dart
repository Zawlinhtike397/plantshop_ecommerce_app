import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPageComponent extends StatelessWidget {
  const OnBoardingPageComponent({
    super.key,
    required this.onBoardingTitle,
    required this.onBoardingSubTitle,
    required this.image,
  });

  final String onBoardingTitle;
  final String onBoardingSubTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.20),
        Lottie.asset(image, width: MediaQuery.sizeOf(context).width * 0.8),
        SizedBox(height: 60.0),
        Column(
          spacing: 10.0,
          children: [
            Text(
              onBoardingTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              onBoardingSubTitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
