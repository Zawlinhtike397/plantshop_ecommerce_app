part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double subtotal;
  final double total;
  final int totalQuantity;
  final double? deliveryFee;
  final double? discountAmount;
  final String? appliedCouponCode;

  const CartLoaded({
    this.items = const [],
    this.subtotal = 0,
    this.total = 0,
    this.totalQuantity = 0,
    this.deliveryFee,
    this.discountAmount,
    this.appliedCouponCode,
  });

  CartLoaded copyWith({
    List<CartItemModel>? items,
    double? subtotal,
    double? total,
    int? totalQuantity,
    double? deliveryFee,
    double? discountAmount,
    String? appliedCouponCode,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discountAmount: discountAmount ?? this.discountAmount,
      appliedCouponCode: appliedCouponCode ?? this.appliedCouponCode,
    );
  }

  @override
  List<Object?> get props => [
    items,
    subtotal,
    total,
    totalQuantity,
    deliveryFee,
    discountAmount,
    appliedCouponCode,
  ];
}
