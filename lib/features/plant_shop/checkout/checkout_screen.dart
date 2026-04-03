import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/common/widgets/listView/address_listview.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/bloc/checkout_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/checkout_success_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/checkout_bottom_sheet.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/payment_method_list_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final double subTotalValue;
  final double totalValue;
  final List<CartItemModel> cartItems;
  final double discountAmount;
  final double deliveryFee;

  const CheckoutScreen({
    super.key,
    required this.subTotalValue,
    required this.totalValue,
    required this.cartItems,
    required this.discountAmount,
    required this.deliveryFee,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedAddressId;
  String? selectedPaymentMethod = 'cb_1';

  @override
  void initState() {
    super.initState();

    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      context.read<AddressBloc>().add(FetchAddresses(user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CheckoutSuccess) {
          Navigator.pop(context);

          context.read<CartBloc>().add(ClearCartEvent());

          final cartRepo = context.read<CartBloc>().cartRepository;
          cartRepo.clearCoupon();

          context.read<CartBloc>().add(LoadCartEvent());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const CheckoutSuccessScreen()),
            (route) => false,
          );
        }

        if (state is CheckoutFailure) {
          Navigator.pop(context);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: const [CartIconBtnWidget()],
          ),

          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoaded) {
                          final addresses = state.addresses;

                          if (selectedAddressId == null &&
                              addresses.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                selectedAddressId = addresses
                                    .firstWhere(
                                      (a) => a.isDefault,
                                      orElse: () => addresses.first,
                                    )
                                    .id;
                              });
                            });
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingWidget(name: 'Shipping to'),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 200,
                                  child: AddressListview(
                                    addresses: addresses,
                                    selectedId: selectedAddressId,
                                    onSelected: (id) {
                                      setState(() {
                                        selectedAddressId = id;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is AddressLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AddressError) {
                          return Center(child: Text(state.message));
                        }

                        return const SizedBox(child: Text('sljofsoifj'));
                      },
                      // child:
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: HeadingWidget(name: 'Payment Method'),
                    ),
                  ),
                  PaymentMethodSliverList(
                    selectedId: selectedPaymentMethod,
                    onSelected: (method) {
                      setState(() {
                        selectedPaymentMethod = method;
                      });
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 140,
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: CheckoutBottomSheet(
                  subTotalValue: widget.subTotalValue,
                  totalValue: widget.totalValue,
                  discountAmount: widget.discountAmount,
                  deliveryFee: widget.deliveryFee,
                  addressId: selectedAddressId ?? '',
                  paymentMethod: selectedPaymentMethod ?? '',
                  items: widget.cartItems ?? [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
