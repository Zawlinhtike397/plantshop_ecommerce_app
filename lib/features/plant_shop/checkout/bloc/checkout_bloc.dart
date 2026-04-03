import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/order_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/model/order_model.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrderRepository orderRepository;
  final DiscountRepository discountRepository;
  CheckoutBloc({
    required this.orderRepository,
    required this.discountRepository,
  }) : super(CheckoutInitial()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      final order = OrderModel(
        userId: user.id,
        addressId: event.addressId,
        paymentMethod: event.paymentMethod,
        totalAmount: event.totalAmount,
        createdAt: DateTime.now(),
        status: 'pending',
        subTotal: event.subTotal,
        discount: event.discount,
        deliveryFee: event.deliveryFee,
      );

      await orderRepository.placeOrder(order: order, items: event.items);

      if (event.couponCode != null) {
        await discountRepository.saveCouponUsage(
          userId: user.id,
          code: event.couponCode!,
        );
      }
      emit(CheckoutSuccess());
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }
}
