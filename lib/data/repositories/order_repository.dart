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
    } catch (e) {
      throw Exception("Failed to place order: $e");
    }
  }

  Future<List<OrderModel>> fetchOrders(String userId) async {
    try {
      final response = await supabase
          .from('orders')
          .select('''
          id,
          user_id,
          address_id,
          payment_method,
          total,
          subtotal,
          discount,
          delivery_fee,
          status,
          created_at,
          address:address_id (
            id,
            user_id,
            contact_name,
            phone,
            home_no,
            street,
            city
          ),
          order_items (
            id,
            order_id,
            plant_id,
            quantity,
            price,
            plants (
            id,
            name,
            price,
            height,
            category,
            stock,
            temperature,
            pot,
            thumbnailImg,
            imageUrl,
            description
            )
          )
        ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      print("FETCH ORDERS RESPONSE: $response");

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
          id,
          user_id,
          address_id,
          payment_method,
          total,
          subtotal,
          discount,
          delivery_fee,
          status,
          created_at,
           address:address_id (
            id,
            user_id,
            contact_name,
            phone,
            home_no,
            street,
            city
          ),
          order_items (
            id,
            order_id,
            plant_id,
            quantity,
            price,
            plants (
              id,
              name,
              imageUrl,
              thumbnailImg
            )
          )
        ''')
          .eq('id', orderId)
          .single();

      print("ORDER DETAIL RESPONSE: $response");
      return OrderModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch order detail: $e");
    }
  }
}
