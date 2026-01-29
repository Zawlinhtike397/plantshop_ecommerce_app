import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            textAlign: TextAlign.center,
            AppText.orLoginWith,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColor.gray),
          ),
        ),
        const Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
      ],
    );
  }
}
