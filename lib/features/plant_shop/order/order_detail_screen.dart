import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/bloc/order_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/model/order_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_detail_row.dart';
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

  void _showCancelConfirmation(String orderId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Cancel Order"),
          content: const Text("Are you sure you want to cancel this order?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                context.read<OrderBloc>().add(CancelOrder(orderId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;

      case 'processing':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;

      case 'shipping':
        backgroundColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;

      case 'delivered':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;

      case 'cancelled':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;

      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
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
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderCancelled) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Order cancelled successfully."),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }

            if (state is OrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is OrderError) {
                return Center(child: Text(state.message));
              }

              if (state is OrderDetailLoaded ||
                  state is OrderCancelling ||
                  state is OrderCancelled) {
                final OrderModel order;

                if (state is OrderDetailLoaded) {
                  order = state.order;
                } else if (state is OrderCancelling) {
                  order = state.order;
                } else {
                  order = (state as OrderCancelled).order;
                } //do i really need this if case?

                final status = order.status?.toLowerCase();

                Widget? actionButton;

                if (status == "pending" || status == "processing") {
                  actionButton = ElevatedButton(
                    onPressed: () {
                      _showCancelConfirmation(order.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Cancel Order"),
                  );
                }

                final plants = order.items!
                    .map((e) => e.plant)
                    .where((p) => p != null)
                    .toList(); //explain this line.

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
                  //also explain this if logic.
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

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<OrderBloc>().add(
                      FetchOrderDetail(widget.orderId),
                    );

                    await context.read<OrderBloc>().stream.firstWhere(
                      (state) =>
                          state is OrderDetailLoaded || state is OrderError,
                    );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Status"),
                                  _buildStatusBadge(order.status ?? "pending"),
                                ],
                              ),
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

                        if (actionButton != null) actionButton,
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
