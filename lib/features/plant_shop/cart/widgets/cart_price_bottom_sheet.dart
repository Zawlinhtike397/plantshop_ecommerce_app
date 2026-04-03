import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/delivery_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/discount_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/subtotal_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/total_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/checkout_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CartPriceBottomSheet extends StatelessWidget {
  final double subtotal;
  final double total;
  final double deliveryFee;
  final double discountAmount;

  const CartPriceBottomSheet({
    super.key,
    required this.isDarkMode,
    required this.subtotal,
    required this.total,
    required this.deliveryFee,
    required this.discountAmount,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? AppColor.darkerGrey : Colors.white70,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Column(
                // spacing: 2.0,
                children: [
                  SubTotalTextWidget(subtotal: subtotal),
                  Divider(color: AppColor.borderColor),
                  DiscountTextWidget(discountAmount: discountAmount),
                  if (discountAmount > 0) Divider(color: AppColor.borderColor),
                  DeliveryTextWidget(deliveryFee: deliveryFee),
                  Divider(color: AppColor.borderColor),
                  TotalTextWidget(total: total),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final state = context.read<CartBloc>().state;

                    final totalQty = state is CartLoaded
                        ? state.totalQuantity
                        : 0;
                    if (state is CartLoaded) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CheckoutScreen(
                              subTotalValue: subtotal,
                              totalValue: total,
                              cartItems: state.items,
                              discountAmount: state.discountAmount ?? 0,
                              deliveryFee: state.deliveryFee ?? 1000,
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('CHECKOUT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
