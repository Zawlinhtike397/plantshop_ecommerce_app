import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/cart_screen.dart';

class CartIconBtnWidget extends StatelessWidget {
  final num totalQuantityValue;
  const CartIconBtnWidget({super.key, this.totalQuantityValue = 0});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Iconsax.shopping_bag,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 25.0,
          ),
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
        ),
        if (totalQuantityValue > 0)
          Positioned(
            top: 5,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                totalQuantityValue < 10
                    ? '0${totalQuantityValue.toString()}'
                    : totalQuantityValue.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
