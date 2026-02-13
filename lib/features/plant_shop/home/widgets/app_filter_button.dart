import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class AppFilterButton extends StatelessWidget {
  final void Function()? onTap;
  final ColorFilter? iconColorFilter;
  final Color? backgroundColor;
  final bool showBorder;

  const AppFilterButton({
    super.key,
    this.onTap,
    this.iconColorFilter,
    this.backgroundColor,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final filterIcon = SvgPicture.asset(
      ImageStrings.filterIcon,
      colorFilter: iconColorFilter,
      width: 25,
      height: 22,
      semanticsLabel: 'filter icon',
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          border: showBorder ? Border.all(color: AppColor.borderColor) : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: filterIcon,
      ),
    );
  }
}
