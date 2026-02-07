import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/common/widgets/container/search_container.dart';
import 'package:plantify_plantshop_project/common/widgets/custom_shapes/custom_curved_edge.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/app_filter_button.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/top_app_bar_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ClipPath(
      clipper: CustomCurvedEdge(),
      child: Container(
        padding: EdgeInsets.only(top: kToolbarHeight),
        color: AppColor.primary,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TopAppBarWidget(),
            ),
            SizedBox(height: 40.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                spacing: 5.0,
                children: [
                  Expanded(
                    child: SearchContainer(
                      searchBarText: 'Search specific plants',
                      icon: Iconsax.search_normal,
                    ),
                  ),
                  AppFilterButton(
                    iconColorFilter: ColorFilter.mode(
                      AppColor.buttonPrimary,
                      BlendMode.srcIn,
                    ),
                    backgroundColor: isDarkMode
                        ? AppColor.darkBackground
                        : AppColor.buttonSecondary,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
