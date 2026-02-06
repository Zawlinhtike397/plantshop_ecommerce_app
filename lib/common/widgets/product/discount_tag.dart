import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class DiscountTag extends StatelessWidget {
  final String percentage;
  const DiscountTag({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, top: 8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColor.accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            percentage,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
