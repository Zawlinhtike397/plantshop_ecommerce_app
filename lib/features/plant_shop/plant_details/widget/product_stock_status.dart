import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/model/stock_status_model.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class ProductStockStatus extends StatelessWidget {
  final PlantModel plant;
  const ProductStockStatus({super.key, required this.plant});

  StockStatus getStatus(int stock) {
    if (stock <= 0) {
      return StockStatus("Out of Stock", Colors.red);
    }

    if (stock <= 5) {
      return StockStatus("Low Stock", const Color.fromARGB(255, 237, 131, 93));
    }

    if (stock <= 10) {
      return StockStatus("Warning level", const Color(0xFFEAB308));
    }

    return StockStatus("In Stock", AppColor.primary);
  }

  @override
  Widget build(BuildContext context) {
    final status = getStatus(plant.stock);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductText(
          name: 'Stock Status',
          overflow: TextOverflow.ellipsis,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: status.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status.label,
            style: TextStyle(color: status.color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
