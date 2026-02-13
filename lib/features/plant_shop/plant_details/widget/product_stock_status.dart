import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';

class ProductStockStatus extends StatelessWidget {
  const ProductStockStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductText(
          name: 'Status',
          overflow: TextOverflow.ellipsis,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        SizedBox(height: 10),
        Text('In Stock'),
      ],
    );
  }
}
