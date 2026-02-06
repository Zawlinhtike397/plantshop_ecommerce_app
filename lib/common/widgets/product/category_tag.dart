import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.darkTeal),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        'Indoor',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: AppColor.darkTeal,
          fontSize: 11.0,
        ),
      ),
    );
  }
}
