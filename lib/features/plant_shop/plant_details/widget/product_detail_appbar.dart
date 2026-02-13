import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/cart_screen.dart';

class ProductDetailAppBar extends StatelessWidget {
  const ProductDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: true,
      snap: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CartScreen();
                },
              ),
            );
          },
          icon: const Icon(Iconsax.shopping_bag),
        ),
      ],
    );
  }
}
