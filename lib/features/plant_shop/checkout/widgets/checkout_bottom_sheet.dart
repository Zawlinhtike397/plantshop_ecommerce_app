import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/bloc/checkout_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final double subTotalValue;
  final double totalValue;
  final String addressId;
  final String paymentMethod;
  final List<CartItemModel> items;
  final double discountAmount;
  final double deliveryFee;

  const CheckoutBottomSheet({
    super.key,
    required this.subTotalValue,
    required this.totalValue,
    required this.addressId,
    required this.paymentMethod,
    required this.items,
    required this.discountAmount,
    required this.deliveryFee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColor.darkerGrey
            : Colors.white70,
        borderRadius: BorderRadius.circular(15.0),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 27.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${subTotalValue.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              if (discountAmount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount'),
                    Text('- \$${discountAmount.toStringAsFixed(2)}'),
                  ],
                ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Fee'),
                  Text('${deliveryFee.toStringAsFixed(0)} MMK'),
                ],
              ),

              const SizedBox(height: 10),
              DottedLine(
                dashColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColor.darkBackground
                    : Colors.white70,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${totalValue.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final cartState = context.read<CartBloc>().state;

                    String? couponCode;

                    if (cartState is CartLoaded) {
                      couponCode = cartState.appliedCouponCode;
                    }

                    if (addressId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an address"),
                        ),
                      );
                      return;
                    }

                    if (addressId.isEmpty || paymentMethod.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Select address & payment"),
                        ),
                      );
                      return;
                    }

                    context.read<CheckoutBloc>().add(
                      PlaceOrderEvent(
                        addressId: addressId,
                        paymentMethod: paymentMethod,
                        totalAmount: totalValue,
                        subTotal: subTotalValue,
                        discount: discountAmount,
                        deliveryFee: deliveryFee,
                        items: items,
                        couponCode: couponCode,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Place Order'),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
