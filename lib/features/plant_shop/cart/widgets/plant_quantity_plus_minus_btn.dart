import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantQuantityPlusMinusBtn extends StatelessWidget {
  final int index;
  final CartItemModel item;
  final bool isDarkMode;

  const PlantQuantityPlusMinusBtn({
    super.key,
    required this.isDarkMode,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            context.read<CartBloc>().add(DecreaseQtyEvent(item.plantId));
          },
          icon: const Icon(Icons.do_not_disturb_on),
          color: isDarkMode ? Colors.white : AppColor.darkerGrey,
          iconSize: 20,
        ),
        Text('${item.quantity}', style: Theme.of(context).textTheme.bodySmall),
        IconButton(
          padding: EdgeInsets.all(0.0),
          splashRadius: 0.1,
          onPressed: () {
            context.read<CartBloc>().add(IncreaseQtyEvent(item.plantId));
          },
          icon: const Icon(Icons.add_circle),
          color: isDarkMode ? Colors.white : AppColor.darkerGrey,
          iconSize: 20,
        ),
      ],
    );
  }
}
