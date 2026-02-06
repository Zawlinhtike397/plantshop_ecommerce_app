import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class FilterButton extends StatelessWidget {
  final void Function()? onTap;

  const FilterButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final filterIcon = SvgPicture.asset(
      ImageStrings.filterIcon,
      colorFilter: const ColorFilter.mode(
        AppColor.buttonPrimary,
        BlendMode.srcIn,
      ),
      semanticsLabel: 'filter icon',
    );

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColor.darkBackground
              : AppColor.buttonSecondary,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: filterIcon,
      ),
    );
  }
}
