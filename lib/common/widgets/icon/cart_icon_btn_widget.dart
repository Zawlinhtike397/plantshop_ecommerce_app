import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/cart_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CartIconBtnWidget extends StatelessWidget {
  const CartIconBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int totalQuantity = 0;

        if (state is CartLoaded) {
          totalQuantity = state.totalQuantity;
        }

        return Stack(
          children: [
            IconButton(
              icon: Icon(
                Iconsax.shopping_bag,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 25.0,
              ),
              onPressed: () {
                context.read<NavigationCubit>().changeIndex(1);
              },
            ),
            if (totalQuantity > 0)
              Positioned(
                top: 2,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  child: Text(
                    totalQuantity < 10
                        ? '0${totalQuantity.toString()}'
                        : totalQuantity.toString(),
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
      },
    );
  }
}
