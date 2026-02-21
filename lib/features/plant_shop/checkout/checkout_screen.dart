import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/common/widgets/listView/address_listview.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/checkout_bottom_sheet.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/payment_method_list_view.dart';

class CheckoutScreen extends StatefulWidget {
  double subTotalValue;
  double totalValue;
  num totalQuantityValue;

  CheckoutScreen({
    super.key,
    required this.subTotalValue,
    required this.totalValue,
    required this.totalQuantityValue,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          actions: [
            CartIconBtnWidget(totalQuantityValue: widget.totalQuantityValue),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 25.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20.0,
                      children: [
                        HeadingWidget(name: 'Shipping to'),

                        SizedBox(height: 200, child: AddressListview()),
                      ],
                    ),

                    HeadingWidget(name: 'Payment Method'),
                    PaymentMethodListView(),
                  ],
                ),
              ),

              CheckoutBottomSheet(
                subTotalValue: widget.subTotalValue,
                totalValue: widget.totalValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
