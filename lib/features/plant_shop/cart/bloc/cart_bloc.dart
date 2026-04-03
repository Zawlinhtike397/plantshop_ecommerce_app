import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  static const double deliveryFee = 1000;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCartEvent>(_loadCart);
    on<AddToCartEvent>(_addToCart);
    on<RemoveCartItemEvent>(_removeItem);
    on<IncreaseQtyEvent>(_increaseQty);
    on<DecreaseQtyEvent>(_decreaseQty);
    on<ApplyDiscountEvent>(_applyDiscount);
    on<ClearCartEvent>((event, emit) {
      cartRepository.clearCart();
      _emitUpdatedCart(emit);
    });
  }

  void _emitUpdatedCart(Emitter<CartState> emit) {
    final items = cartRepository.getCartItems();
    final subtotal = cartRepository.subtotal;

    final savedCoupon = cartRepository.appliedCoupon;
    double discountAmount = 0;

    if (savedCoupon != null) {
      discountAmount = savedCoupon.discountAmount;
    }

    final total = subtotal + deliveryFee - discountAmount;

    emit(
      CartLoaded(
        items: items,
        subtotal: subtotal,
        total: total,
        totalQuantity: cartRepository.totalQuantity,
        deliveryFee: deliveryFee,
        discountAmount: discountAmount,
        appliedCouponCode: savedCoupon?.code,
      ),
    );
  }

  void _loadCart(LoadCartEvent event, Emitter<CartState> emit) {
    _emitUpdatedCart(emit);
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) {
    cartRepository.addToCart(event.item);
    _emitUpdatedCart(emit);
  }

  void _removeItem(RemoveCartItemEvent event, Emitter<CartState> emit) {
    cartRepository.removeItem(event.plantId);
    _emitUpdatedCart(emit);
  }

  void _increaseQty(IncreaseQtyEvent event, Emitter<CartState> emit) {
    cartRepository.increaseQty(event.plantId);
    _emitUpdatedCart(emit);
  }

  void _decreaseQty(DecreaseQtyEvent event, Emitter<CartState> emit) {
    cartRepository.decreaseQty(event.plantId);
    _emitUpdatedCart(emit);
  }

  void _applyDiscount(ApplyDiscountEvent event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      cartRepository.saveCoupon(
        AppliedCouponModel(
          code: event.code,
          discountAmount: event.discountAmount,
        ),
      );

      final newTotal =
          currentState.subtotal + deliveryFee - event.discountAmount;

      emit(
        currentState.copyWith(
          discountAmount: event.discountAmount,
          appliedCouponCode: event.code,
          total: newTotal,
        ),
      );
    }
  }
}
