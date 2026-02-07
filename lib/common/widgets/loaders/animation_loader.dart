import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class AnimationLoader extends StatelessWidget {
  final String headingText;
  final String animation;
  final void Function()? onPressed;
  final bool showActionButton;
  final String smallText;
  final String? actionText;

  const AnimationLoader({
    super.key,
    required this.headingText,
    required this.animation,
    this.onPressed,
    this.showActionButton = false,
    this.actionText,
    required this.smallText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        LottieBuilder.asset(
          animation,
          width: MediaQuery.sizeOf(context).width * 0.8,
        ),
        Text(
          headingText,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          smallText,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        showActionButton
            ? SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                  ),
                  onPressed: onPressed,
                  child: Text(
                    actionText!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: AppColor.white),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
