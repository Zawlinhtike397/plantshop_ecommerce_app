import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {
  final bool markedAsFavourite;
  const FavouriteIcon({super.key, required this.markedAsFavourite});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode ? AppColor.darkBackground : Colors.grey.shade200,
      ),
      // padding: const EdgeInsets.all(2),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          markedAsFavourite ? Icons.favorite : Icons.favorite,
          color: markedAsFavourite ? AppColor.primary : AppColor.white,
          size: 20,
        ),
      ),
    );
  }
}
