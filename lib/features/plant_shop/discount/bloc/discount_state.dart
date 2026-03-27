part of 'discount_bloc.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object?> get props => [];
}

final class DiscountInitial extends DiscountState {}

final class DiscountLoading extends DiscountState {}

final class DiscountLoaded extends DiscountState {
  final List<DiscountModel> discounts;
  final DiscountStatus status;
  final String? message;
  final double? discountAmount;
  final double? newTotal;
  final DiscountModel? appliedDiscount;

  const DiscountLoaded(
    this.discounts, {
    this.status = DiscountStatus.initial,
    this.message,
    this.discountAmount,
    this.newTotal,
    this.appliedDiscount,
  });

  DiscountLoaded copyWith({
    List<DiscountModel>? discounts,
    DiscountStatus? status,
    String? message,
    double? discountAmount,
    double? newTotal,
    DiscountModel? appliedDiscount,
  }) {
    return DiscountLoaded(
      discounts ?? this.discounts,
      status: status ?? this.status,
      message: message,
      discountAmount: discountAmount,
      newTotal: newTotal,
      appliedDiscount: appliedDiscount,
    );
  }

  @override
  List<Object?> get props => [
    discounts,
    status,
    message,
    discountAmount,
    newTotal,
    appliedDiscount,
  ];
}

final class DiscountUploading extends DiscountState {}

final class DiscountUploaded extends DiscountState {}

final class CouponApplied extends DiscountState {
  final double newTotal;
  final DiscountModel discount;
  final double discountAmount;

  const CouponApplied({
    required this.newTotal,
    required this.discount,
    required this.discountAmount,
  });

  @override
  List<Object> get props => [newTotal, discount, discountAmount];
}

final class CouponInvalid extends DiscountState {
  final String message;

  const CouponInvalid(this.message);

  @override
  List<Object> get props => [message];
}

final class DiscountError extends DiscountState {
  final String message;

  const DiscountError(this.message);

  @override
  List<Object> get props => [message];
}
