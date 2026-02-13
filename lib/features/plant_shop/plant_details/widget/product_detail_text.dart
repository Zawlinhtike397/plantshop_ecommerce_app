import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';

class ProductDetailText extends StatelessWidget {
  final Map<String, Object> plantData;
  const ProductDetailText({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductText(
          name: '${plantData['name']}',
          overflow: TextOverflow.ellipsis,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        const SizedBox(height: 15),
        Text(
          '${plantData['description']}',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
