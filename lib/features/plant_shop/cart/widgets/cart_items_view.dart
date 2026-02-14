import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/plant_cart_item.dart';

class CartItemsView extends StatelessWidget {
  const CartItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
      child: ListView.separated(
        itemCount: 8,
        itemBuilder: (context, index) {
          return PlantCartItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 5.0);
        },
      ),
    );
  }
}
