import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final supabase = Supabase.instance.client;

  Future<void> placeOrder({
    required OrderModel order,
    required List<CartItemModel> items,
  }) async {
    try {
      final orderResponse = await supabase
          .from('orders')
          .insert(order.toJson())
          .select()
          .single();

      final orderId = orderResponse['id'];

      final orderItems = items.map((item) {
        return {
          'order_id': orderId,
          'plant_id': item.plantId,
          'quantity': item.quantity,
          'price': item.price,
        };
      }).toList();

      await supabase.from('order_items').insert(orderItems);

      for (final item in items) {
        final plantResponse = await supabase
            .from('plants')
            .select('stock')
            .eq('id', item.plantId)
            .single();

        final currentStock = plantResponse['stock'] ?? 0;

        if (currentStock < item.quantity) {
          throw Exception('Not enough stock for plant  ${item.name}');
        }

        final updatedStock = currentStock - item.quantity;

        await supabase
            .from('plants')
            .update({'stock': updatedStock})
            .eq('id', item.plantId);
      }
    } catch (e) {
      throw Exception("Failed to place order: $e");
    }
  }

  Future<List<OrderModel>> fetchOrders(String userId) async {
    try {
      final response = await supabase
          .from('orders')
          .select('*,address:address_id (*),order_items (*, plants (*))')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  Future<OrderModel> fetchOrderDetail(String orderId) async {
    try {
      final response = await supabase
          .from('orders')
          .select('''
          *,
           address:address_id (*),
          order_items (
            *,
            plants (*)
          )
        ''')
          .eq('id', orderId)
          .single();

      return OrderModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch order detail: $e");
    }
  }

  Future<bool> hasUserPlacedOrder(String userId) async {
    final response = await supabase
        .from('orders')
        .select('id')
        .eq('user_id', userId)
        .limit(1);

    return response.isNotEmpty;
  }
}
