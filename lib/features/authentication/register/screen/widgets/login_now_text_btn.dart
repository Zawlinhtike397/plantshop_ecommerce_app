import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/login_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class LoginNowTextBtn extends StatelessWidget {
  const LoginNowTextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppText.alrdyHaveAccText,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            AppText.loginNowText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
