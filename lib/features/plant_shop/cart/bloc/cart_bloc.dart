import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  final DiscountRepository discountRepository;

  static const double deliveryFee = 1000;

  CartBloc({required this.cartRepository, required this.discountRepository})
    : super(CartInitial()) {
    on<LoadCartEvent>(_loadCart);
    on<AddToCartEvent>(_addToCart);
    on<RemoveCartItemEvent>(_removeItem);
    on<IncreaseQtyEvent>(_increaseQty);
    on<DecreaseQtyEvent>(_decreaseQty);
    on<ApplyDiscountEvent>(_applyDiscount);
    on<ClearCartEvent>((event, emit) async {
      cartRepository.clearCart();
      await _emitUpdatedCart(emit);
    });
  }

  Future<void> _emitUpdatedCart(Emitter<CartState> emit) async {
    final items = cartRepository.getCartItems();
    final subtotal = cartRepository.subtotal;

    if (items.isEmpty) {
      await cartRepository.clearCoupon();
    }

    var savedCoupon = cartRepository.appliedCoupon;
    double discountAmount = 0;

    // if (savedCoupon != null) {
    //   discountAmount = (subtotal * savedCoupon.percentage) / 100;
    // }

    if (savedCoupon != null) {
      final couponMinRequirements = savedCoupon.minAmount ?? 0;

      if (subtotal < couponMinRequirements) {
        final couponCodeToClear = savedCoupon.code;

        await cartRepository.clearCoupon();
        savedCoupon = null;

        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          try {
            await discountRepository.removeCouponUsage(
              userId: user.id,
              code: couponCodeToClear,
            );
          } catch (e) {
            print("Failed to sync coupon removal to Supabase: $e");
          }
        }
      } else {
        discountAmount = (subtotal * savedCoupon.percentage) / 100;
      }
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

  Future<void> _loadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    await _emitUpdatedCart(emit);
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    cartRepository.addToCart(event.item);
    await _emitUpdatedCart(emit);
  }

  Future<void> _removeItem(
    RemoveCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    cartRepository.removeItem(event.plantId);
    await _emitUpdatedCart(emit);
  }

  Future<void> _increaseQty(
    IncreaseQtyEvent event,
    Emitter<CartState> emit,
  ) async {
    cartRepository.increaseQty(event.plantId);
    await _emitUpdatedCart(emit);
  }

  Future<void> _decreaseQty(
    DecreaseQtyEvent event,
    Emitter<CartState> emit,
  ) async {
    cartRepository.decreaseQty(event.plantId);
    await _emitUpdatedCart(emit);
  }

  Future<void> _applyDiscount(
    ApplyDiscountEvent event,
    Emitter<CartState> emit,
  ) async {
    await cartRepository.saveCoupon(
      AppliedCouponModel(
        code: event.code,
        percentage: event.percentage,
        minAmount: event.minAmount,
      ),
    );

    await _emitUpdatedCart(emit);
  }
}
