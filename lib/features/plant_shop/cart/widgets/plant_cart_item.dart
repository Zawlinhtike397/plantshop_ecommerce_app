import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_price_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/plant_quantity_plus_minus_btn.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantCartItem extends StatelessWidget {
  final CartItemModel item;
  final int index;

  const PlantCartItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.width * 0.31,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Card(
            elevation: 0.2,
            color: isDarkMode ? AppColor.darkerGrey : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Row(
                children: [
                  Image.network(item.image, fit: BoxFit.fitWidth),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            spacing: 20.0,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  item.name,
                                  maxLines: 2,

                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              AppProductPriceText(
                                price: '${item.price}',
                                isLarge: false,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 6.0,
                          children: [
                            SizedBox(height: 11),
                            AppProductPriceText(
                              price: '${item.totalPrice}',
                              isLarge: false,
                            ),

                            PlantQuantityPlusMinusBtn(
                              isDarkMode: isDarkMode,
                              index: index,
                              item: item,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: -1,
            right: 4,
            child: IconButton(
              onPressed: () {
                context.read<CartBloc>().add(RemoveCartItemEvent(item.plantId));
              },
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : AppColor.darkerGrey,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
