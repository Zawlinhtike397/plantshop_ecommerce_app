import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/loaders/animation_loader.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/cart_items_view.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/cart_price_bottom_sheet.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/discount_cupon_text_field.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int activePage = 0;
  final TextEditingController cuponCodeController = TextEditingController();
  final PageController _pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  void dispose() {
    super.dispose();
    cuponCodeController.dispose();
  }

  void onTapBottomNav(int pageIndex) {
    _pageViewController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<DiscountBloc, DiscountState>(
        listener: (context, state) {
          if (state is DiscountLoaded) {
            if (state.status == DiscountStatus.success) {
              context.read<CartBloc>().add(
                ApplyDiscountEvent(
                  discountAmount: state.discountAmount!,
                  code: state.appliedDiscount!.code,
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Coupon Applied! New Total: ${state.newTotal!.toStringAsFixed(0)}',
                  ),
                ),
              );
            }

            if (state.status == DiscountStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message ?? 'Error')));
            }
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is! CartLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.items.isEmpty) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: Center(
                    child: AnimationLoader(
                      headingText: 'Cart is empty!',
                      animation: ImageStrings.emptyAnimation,
                      smallText: 'Let\'s add something to your cart',
                      showActionButton: false,
                    ),
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CartItemsView(items: state.items),
                  DiscountCuponTextField(
                    isDarkMode: isDarkMode,
                    cuponCodeController: cuponCodeController,
                  ),
                  CartPriceBottomSheet(
                    subtotal: state.subtotal,
                    total: state.total,
                    isDarkMode: isDarkMode,
                    deliveryFee: state.deliveryFee ?? 0,
                    discountAmount: state.discountAmount ?? 0.0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
