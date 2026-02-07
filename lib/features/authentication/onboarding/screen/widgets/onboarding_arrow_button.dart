import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/utils/themes/app_theme.dart';

class OnBoardingArrowButton extends StatelessWidget {
  final PageController pageController;

  const OnBoardingArrowButton({super.key, required this.pageController});

  void goNextPage(BuildContext context) {
    final currentPage = pageController.page?.round() ?? 0;

    if (currentPage < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<AppBloc>().add(AppOnboardingCompleted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(90, 90),
            shape: const CircleBorder(side: BorderSide.none),
            backgroundColor: AppTheme.lightTheme.primaryColor,
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            goNextPage(context);
          },
          child: const Icon(
            Icons.arrow_forward,
            size: 45.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
