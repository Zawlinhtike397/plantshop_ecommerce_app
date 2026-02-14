import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantQuantityPlusMinusBtn extends StatelessWidget {
  const PlantQuantityPlusMinusBtn({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.do_not_disturb_on),
          color: isDarkMode ? Colors.white : AppColor.darkerGrey,
          iconSize: 20,
        ),
        Text('02', style: Theme.of(context).textTheme.bodySmall),
        IconButton(
          padding: EdgeInsets.all(0.0),
          splashRadius: 0.1,
          onPressed: () {},
          icon: const Icon(Icons.add_circle),
          color: isDarkMode ? Colors.white : AppColor.darkerGrey,
          iconSize: 20,
        ),
      ],
    );
  }
}
