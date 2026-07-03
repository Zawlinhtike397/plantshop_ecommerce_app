import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_stock_status.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class AddToCartButton extends StatelessWidget {
  final PlantModel plant;
  const AddToCartButton({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final stockStatus = ProductStockStatus(plant: plant).getStatus(plant.stock);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: stockStatus.label == "Out of Stock"
            ? Colors.grey
            : AppColor.primary,
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 23),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: stockStatus.label == "Out of Stock"
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${plant.name} is Out of Stock')),
              );
              return;
            }
          : () {
              context.read<CartBloc>().add(
                AddToCartEvent(
                  CartItemModel(
                    plantId: plant.id,
                    name: plant.name,
                    price: plant.originalPrice,
                    image: plant.imageUrl.first,
                  ),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${plant.name} added to cart')),
              );
            },
      child: const Text('Add to Cart'),
    );
  }
}
