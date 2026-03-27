import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class DiscountCuponTextField extends StatelessWidget {
  const DiscountCuponTextField({
    super.key,
    required this.isDarkMode,
    required this.cuponCodeController,
  });

  final bool isDarkMode;
  final TextEditingController cuponCodeController;

  void applyCoupon(BuildContext context) {
    final code = cuponCodeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter coupon code")));
      return;
    }

    final cartState = context.read<CartBloc>().state;
    final userState = context.read<UserBloc>().state;

    if (cartState is! CartLoaded || userState is! UserLoaded) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
      return;
    }

    context.read<DiscountBloc>().add(
      ApplyCoupon(
        userId: userState.user.id,
        code: code,
        cartTotal: cartState.total,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          tileColor: isDarkMode
              ? AppColor.midGray.withValues(alpha: 0.5)
              : Colors.white,
          leading: Icon(Iconsax.discount_shape),
          title: TextField(
            controller: cuponCodeController,
            decoration: InputDecoration(
              hintText: 'Promo Code',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonPrimary,
            ),
            onPressed: () {
              applyCoupon(context);
            },
            child: const Text('Apply'),
          ),
        ),
      ),
    );
  }
}
