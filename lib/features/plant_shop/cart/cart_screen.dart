import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/cart_items_view.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/cart_price_bottom_sheet.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/discount_cupon_text_field.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int activePage = 0;
  final TextEditingController cuponCodeController = TextEditingController();
  final PageController _pageViewController = PageController();

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     //?
  //     Provider.of<NavigationProvider>(context, listen: false)
  //         .setShowBottomNavBar(false);
  //   });
  // }

  @override
  void dispose() {
    // Provider.of<NavigationProvider>(context, listen: false)
    //     .setShowBottomNavBar(true);
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

  // int quantity = 1;
  @override
  Widget build(BuildContext context) {
    // final cartProvider = context.watch<CartProviderState>();
    // final cart = cartProvider.cartData;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cart = [];

    num totalQuantity = 0;
    double subTotal = 0.0;
    for (var cartItem in cart) {
      subTotal += (cartItem['price'] * cartItem['quantity']);
      totalQuantity += cartItem['quantity'];
    }

    const double deliveryFee = 3.46;
    double total = subTotal + deliveryFee;

    String cuponCode = 'ZORO';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body:
          // cart.isEmpty
          //     ? const Center(child: Text('Cart is Empty'))
          //     :
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CartItemsView(),

                DiscountCuponTextField(
                  isDarkMode: isDarkMode,
                  cuponCodeController: cuponCodeController,
                ),
                // Spacer(),
                CartPriceBottomSheet(isDarkMode: isDarkMode),
              ],
            ),
          ),
    );
  }
}
