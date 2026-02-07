import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class AppFilterButton extends StatelessWidget {
  final void Function()? onTap;
  final ColorFilter? iconColorFilter;
  final Color? backgroundColor;

  const AppFilterButton({
    super.key,
    this.onTap,
    this.iconColorFilter,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final filterIcon = SvgPicture.asset(
      ImageStrings.filterIcon,
      colorFilter: iconColorFilter,

      semanticsLabel: 'filter icon',
    );

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: filterIcon,
      ),
    );
  }
}
