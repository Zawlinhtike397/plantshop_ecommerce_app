import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailImageSlider extends StatelessWidget {
  final PageController controller;
  final Map<String, Object> plantData;
  const ProductDetailImageSlider({
    super.key,
    required this.controller,
    required this.plantData,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final List<String> plantImgList = plantData['imageUrl'] as List<String>;
    return SizedBox(
      height: screenHeight * 0.4,
      width: double.infinity,

      child: Stack(
        children: [
          PageView.builder(
            itemCount: plantImgList.length,
            scrollDirection: Axis.vertical,
            controller: controller,
            itemBuilder: ((context, index) {
              return Image.asset(plantImgList[index], fit: BoxFit.cover);
            }),
          ),
          if (plantImgList.length > 1)
            Positioned(
              bottom: -1,
              right: 105,
              child: SmoothPageIndicator(
                axisDirection: Axis.vertical,
                controller: controller,
                count: plantImgList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6.0,
                  dotWidth: 6.0,
                  activeDotColor: AppColor.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
