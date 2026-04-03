part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class UploadAddressData extends AddressEvent {}

class FetchAddresses extends AddressEvent {
  final String userId;

  const FetchAddresses(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddAddress extends AddressEvent {
  final AddressModel address;

  const AddAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdateAddress extends AddressEvent {
  final AddressModel address;

  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class DeleteAddress extends AddressEvent {
  final String id;
  final String userId;

  const DeleteAddress(this.id, this.userId);

  @override
  List<Object?> get props => [id];
}

class SetDefaultAddress extends AddressEvent {
  final String userId;
  final String addressId;

  const SetDefaultAddress(this.userId, this.addressId);
}
