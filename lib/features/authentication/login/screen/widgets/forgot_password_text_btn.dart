import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';
import 'package:plantify_plantshop_project/utils/themes/theme.dart';

class ForgotPasswordTextBtn extends StatelessWidget {
  const ForgotPasswordTextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            AppText.forgotPwText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              // fontSize: 14.0,
              color: AppTheme.lightTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
