part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrders extends OrderEvent {}

class FetchOrderDetail extends OrderEvent {
  final String orderId;

  const FetchOrderDetail(this.orderId);
}
