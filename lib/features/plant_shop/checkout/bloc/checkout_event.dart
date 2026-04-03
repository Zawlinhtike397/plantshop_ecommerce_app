part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends CheckoutEvent {
  final String addressId;
  final String paymentMethod;
  final double totalAmount;
  final double subTotal;
  final double discount;
  final double deliveryFee;
  final List<CartItemModel> items;
  final String? couponCode;

  const PlaceOrderEvent({
    required this.addressId,
    required this.paymentMethod,
    required this.totalAmount,
    required this.subTotal,
    required this.discount,
    required this.deliveryFee,
    required this.items,
    this.couponCode,
  });

  @override
  List<Object?> get props => [
    addressId,
    paymentMethod,
    totalAmount,
    subTotal,
    discount,
    deliveryFee,
    items,
    couponCode,
  ];
}
