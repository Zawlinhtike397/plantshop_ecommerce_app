import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class SearchContainer extends StatelessWidget {
  final IconData? icon;
  final String searchBarText;
  final bool showColor, showBorder;

  const SearchContainer({
    super.key,
    this.icon,
    required this.searchBarText,
    this.showColor = true,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: AppColor.borderColor) : null,
        color: showColor
            ? isDarkMode
                  ? AppColor.darkBackground
                  : AppColor.lightGray
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Row(
          spacing: 10.0,
          children: [
            Icon(
              icon,
              // Iconsax.search_normal,
              color: AppColor.midGray,
            ),
            Text(
              searchBarText,
              // ZTexts.serachBarHintText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColor.gray),
            ),
          ],
        ),
      ),
    );
  }
}
