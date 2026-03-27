part of 'discount_bloc.dart';

sealed class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class FetchDiscounts extends DiscountEvent {}

class UploadDiscounts extends DiscountEvent {}

class ApplyCoupon extends DiscountEvent {
  final String userId;
  final String code;
  final double cartTotal;

  const ApplyCoupon({
    required this.userId,
    required this.code,
    required this.cartTotal,
  });

  @override
  List<Object> get props => [userId, code, cartTotal];
}
