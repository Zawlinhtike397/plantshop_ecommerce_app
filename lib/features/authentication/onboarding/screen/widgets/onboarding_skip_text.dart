import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';

class OnBoardingSkipText extends StatelessWidget {
  const OnBoardingSkipText({super.key});

  void skipOnBoarding(BuildContext context) {
    context.read<AppBloc>().add(AppOnboardingCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10, top: 40.0),
        child: TextButton(
          onPressed: () {
            //why do i need to wrap like this? what is closure?
            skipOnBoarding(context);
          },
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
