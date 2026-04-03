import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/bloc/order_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/order_detail_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_card.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/helper_functions/status_color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrders());
  }

  Widget _tab(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primary),
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? Colors.white : Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 15),

            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is OrderError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is OrderLoaded) {
                    if (state.orders.isEmpty) {
                      return const Center(child: Text("No orders yet"));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<OrderBloc>().add(FetchOrders());
                      },
                      child: ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];

                          print("ORDER: ${order.toString()}");

                          String title = "Order";
                          String? thumnailImage;

                          if (order.items!.isNotEmpty) {
                            final firstItem = order.items!.first;

                            final plantName = firstItem.plant?.name ?? "Plant";
                            thumnailImage = firstItem.plant?.thumbnailImg ?? '';

                            if (order.items!.length > 1) {
                              title =
                                  "$plantName +${order.items!.length - 1} more";
                            } else {
                              title = plantName;
                            }
                          }

                          print(
                            "USER NAME: ${Supabase.instance.client.auth.currentUser?.userMetadata}",
                          );
                          final user =
                              Supabase
                                  .instance
                                  .client
                                  .auth
                                  .currentUser
                                  ?.userMetadata?['name']
                                  ?.toString() ??
                              "User";

                          return OrderCard(
                            orderId: order.id ?? '',
                            title: title,
                            date:
                                "${order.createdAt!.day} ${order.createdAt!.month}, ${order.createdAt!.year}",
                            name: user,
                            price:
                                "${order.totalAmount.toStringAsFixed(0)} MMK",
                            status: order.status ?? 'pending',
                            color: statusColor(order.status!),
                            image: thumnailImage,
                            onTap: () {
                              final orderBloc = context.read<OrderBloc>();

                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          OrderDetailScreen(orderId: order.id!),
                                    ),
                                  )
                                  .then((_) {
                                    orderBloc.add(FetchOrders());
                                  });
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
