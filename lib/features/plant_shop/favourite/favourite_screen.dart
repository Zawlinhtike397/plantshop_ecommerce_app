import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/common/widgets/container/search_container.dart';
import 'package:plantify_plantshop_project/common/widgets/loaders/animation_loader.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/app_filter_button.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;
    var wishList = [PlantCard(), PlantCard(), PlantCard(), PlantCard()];

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
        backgroundColor: isDarkMode ? AppColor.darkerGrey : AppColor.primary,
      ),
      body: wishList.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  spacing: 18.0,
                  children: [
                    Row(
                      spacing: 14.0,
                      children: [
                        Expanded(
                          child: SearchContainer(
                            searchBarText: 'Search Specific plants',
                            showBorder: true,
                            icon: Iconsax.search_normal,
                          ),
                        ),
                        AppFilterButton(
                          iconColorFilter: ColorFilter.mode(
                            AppColor.white,
                            BlendMode.srcIn,
                          ),
                          backgroundColor: AppColor.primary,
                          onTap: () {},
                        ),
                      ],
                    ),
                    GridViewWidget(
                      itemCount: 6,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return const PlantCard();
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: AnimationLoader(
                headingText: 'Wishlist is empty!',
                animation: ImageStrings.emptyAnimation,
                smallText: 'Add Something that you wish to buy here ',
                showActionButton: true,
                actionText: 'Add Products',
              ),
            ),
    );
  }
}
