import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';

class ProductDetailAppBar extends StatelessWidget {
  const ProductDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: true,
      snap: true,
      elevation: 0,
    );
  }
}
