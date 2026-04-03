import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/bloc/order_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_detail_row.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_detail_timeline.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_detail_image_slider.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderDetail(widget.orderId));
  }

  static Widget section({
    required String title,
    required Widget child,
    required isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.darkerGrey : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Detail"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            if (state is OrderDetailLoaded) {
              final order = state.order;

              final plants = order.items!
                  .map((e) => e.plant)
                  .where((p) => p != null)
                  .toList();

              Widget imageSection;

              if (plants.isNotEmpty) {
                imageSection = ProductDetailImageSlider(
                  controller: _controller,
                  plantData: plants.first!,
                  isNetworkImage: true,
                );
              } else {
                imageSection = Container(
                  height: 220,
                  color: Colors.grey.shade300,
                );
              }

              String title = "Order";
              if (order.items!.isNotEmpty) {
                final first = order.items!.first.plant?.name ?? "Plant";

                if (order.items!.length > 1) {
                  title = "$first +${order.items!.length - 1} more";
                } else {
                  title = first;
                }
              }

              final subtotal = order.subTotal;
              final discount = order.discount;
              final deliveryFee = order.deliveryFee;
              final total = order.totalAmount;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    imageSection,

                    const SizedBox(height: 20),

                    section(
                      isDarkMode:
                          Theme.of(context).brightness == Brightness.dark,
                      title: "Product Info",
                      child: Column(
                        children: [
                          OrderDetailRow(left: "Product", right: title),
                          OrderDetailRow(
                            left: "Order Date",
                            right:
                                "${order.createdAt!.day}-${order.createdAt!.month}-${order.createdAt!.year}",
                          ),
                          OrderDetailRow(
                            left: "Order ID",
                            right: order.id!.substring(0, 6),
                          ),
                          OrderDetailRow(left: "Status", right: order.status!),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    section(
                      isDarkMode:
                          Theme.of(context).brightness == Brightness.dark,
                      title: "Delivery Address",
                      child: order.address != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.address!.contactName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(order.address!.phone),
                                const SizedBox(height: 4),
                                Text(
                                  "${order.address!.homeNo}, ${order.address!.street}, ${order.address!.city}",
                                ),
                              ],
                            )
                          : const Text("No address found"),
                    ),

                    const SizedBox(height: 15),

                    section(
                      isDarkMode:
                          Theme.of(context).brightness == Brightness.dark,
                      title: "Order Price",
                      child: Column(
                        children: [
                          OrderDetailRow(
                            left: "Subtotal",
                            right: "${subtotal.toStringAsFixed(0)} MMK",
                          ),
                          if (discount > 0)
                            OrderDetailRow(
                              left: "Discount",
                              right: "${discount.toStringAsFixed(0)} MMK",
                            ),
                          OrderDetailRow(
                            left: "Delivery Fee",
                            right: "${deliveryFee.toStringAsFixed(0)} MMK",
                          ),
                          const Divider(),
                          OrderDetailRow(
                            left: "Total",
                            right: "${total.toStringAsFixed(0)}MMK",
                            bold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Mark as delivered"),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
