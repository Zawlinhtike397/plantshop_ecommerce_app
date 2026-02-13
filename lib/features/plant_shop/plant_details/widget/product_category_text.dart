import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';

class ProductCategoryText extends StatelessWidget {
  final Map<String, Object> plantData;
  const ProductCategoryText({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductText(
          name: 'Category',
          overflow: TextOverflow.ellipsis,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        SizedBox(height: 10),
        Text('${plantData['category']}'),
      ],
    );
  }
}
