import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class RegisterNowText extends StatelessWidget {
  const RegisterNowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppText.notHaveAccText,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {},
          child: Text(
            AppText.registerNowText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
