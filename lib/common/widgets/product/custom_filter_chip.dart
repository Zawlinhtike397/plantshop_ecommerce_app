import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final double borderRadius;
  final bool showColor;
  final bool showBorder;
  final Color borderColor;

  const CustomFilterChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.borderRadius = 12,
    this.showColor = true,
    this.showBorder = false,
    this.borderColor = AppColor.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: showColor
            ? isSelected
                  ? AppColor.primary
                  : Colors.transparent
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isDarkMode
              ? AppColor.textWhite
              : isSelected
              ? AppColor.textWhite
              : AppColor.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
