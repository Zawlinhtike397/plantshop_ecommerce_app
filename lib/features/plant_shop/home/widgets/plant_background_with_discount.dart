import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/widgets/container/circular_container.dart';
import 'package:plantify_plantshop_project/common/widgets/product/discount_tag.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/popups/shimmer_effect.dart';

class PlantBackgroundWithDiscount extends StatelessWidget {
  // final Map<String, Object> plantData;
  final PlantModel plantData;
  final bool isNetworkImage;
  const PlantBackgroundWithDiscount({
    super.key,
    required this.plantData,
    required this.isNetworkImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final List<String> images = plantData.imageUrl;
    return Stack(
      children: [
        CircularContainer(
          color: isDarkMode
              ? Color.fromARGB(255, 51, 50, 50)
              : AppColor.lightGray,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: images[0],
                  placeholder: (context, url) =>
                      const ZShimmerEffect(width: 72, height: 72),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image.asset(
                  images[0],
                  width: double.infinity,
                  // fit: BoxFit.contain,
                ),
        ),
        if (plantData.salePrice < plantData.price)
          DiscountTag(
            percentage: '${plantData.discountPercent.toStringAsFixed(0)}%',
          ),
      ],
    );
  }
}
