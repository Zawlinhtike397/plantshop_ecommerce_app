import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/widgets/discount_card.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Discount Offers',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(height: 20.0),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(name: 'Discount Cupons'),
                  SizedBox(height: 20.0),
                  DiscountCard(),
                ],
              );
            }
            return DiscountCard();
          },
        ),
      ),
    );
  }
}
