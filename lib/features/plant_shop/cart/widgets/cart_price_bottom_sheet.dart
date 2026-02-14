import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/delivery_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/subtotal_text_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/total_text_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CartPriceBottomSheet extends StatelessWidget {
  const CartPriceBottomSheet({super.key, required this.isDarkMode});

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
                  SubTotalTextWidget(),
                  Divider(color: AppColor.borderColor),
                  DeliveryTextWidget(),
                  Divider(color: AppColor.borderColor),
                  TotalTextWidget(),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
