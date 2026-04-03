import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/order_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<FetchOrders>(_fetchOrders);
    on<FetchOrderDetail>(_fetchOrderDetail);
  }

  Future<void> _fetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      final orders = await orderRepository.fetchOrders(user.id);

      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _fetchOrderDetail(
    FetchOrderDetail event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    try {
      final order = await orderRepository.fetchOrderDetail(event.orderId);
      emit(OrderDetailLoaded(order));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
