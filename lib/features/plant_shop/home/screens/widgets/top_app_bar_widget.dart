import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/image/rounded_image.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class TopAppBarWidget extends StatelessWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12.0,
          children: [
            AppRoundedImage(
              width: 52,
              height: 52,
              imageUrl: ImageStrings.profile1,
            ),
            Column(
              spacing: 3.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.welcomeText,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Shyvana',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
