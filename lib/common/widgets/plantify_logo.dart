import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class PlantifyLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const PlantifyLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image(image: AssetImage(ImageStrings.plantifyLogo)),
    );
  }
}
