import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/register_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class RegisterNowTextBtn extends StatelessWidget {
  const RegisterNowTextBtn({super.key});

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
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
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
