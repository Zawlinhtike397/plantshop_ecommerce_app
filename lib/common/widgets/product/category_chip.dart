import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.chipColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
