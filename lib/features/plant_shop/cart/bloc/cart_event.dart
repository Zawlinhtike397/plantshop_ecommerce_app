part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItemModel item;

  const AddToCartEvent(this.item);
}

class RemoveCartItemEvent extends CartEvent {
  final int plantId;

  const RemoveCartItemEvent(this.plantId);
}

class IncreaseQtyEvent extends CartEvent {
  final int plantId;

  const IncreaseQtyEvent(this.plantId);
}

class DecreaseQtyEvent extends CartEvent {
  final int plantId;

  const DecreaseQtyEvent(this.plantId);
}

class ApplyDiscountEvent extends CartEvent {
  final double percentage;
  final String code;
  final int minAmount;

  const ApplyDiscountEvent({
    required this.percentage,
    required this.code,
    required this.minAmount,
  });

  @override
  List<Object> get props => [percentage, code, minAmount];
}

class ClearCartEvent extends CartEvent {}
