import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/plant_cart_item.dart';

class CartItemsView extends StatelessWidget {
  final List<CartItemModel> items;

  const CartItemsView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PlantCartItem(item: items[index], index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 5.0);
        },
      ),
    );
  }
}
