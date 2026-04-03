import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/address_repository.dart';
import 'package:plantify_plantshop_project/data/sample_address_data.dart';
import '../model/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;

  AddressBloc({required this.addressRepository}) : super(AddressInitial()) {
    on<UploadAddressData>(_uploadAddressData);
    on<FetchAddresses>(_fetchAddresses);
    on<AddAddress>(_addAddress);
    on<UpdateAddress>(_updateAddress);
    on<DeleteAddress>(_deleteAddress);
    on<SetDefaultAddress>(_setDefaultAddress);
  }

  Future<void> _uploadAddressData(
    UploadAddressData event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(AddressLoading());

      await addressRepository.uploadAddresses(getSampleAddresses());

      emit(AddressUploaded());
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _fetchAddresses(
    FetchAddresses event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(AddressLoading());

      final addresses = await addressRepository.getAddresses(event.userId);

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _addAddress(AddAddress event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());

      await addressRepository.addAddress(event.address);

      final addresses = await addressRepository.getAddresses(
        event.address.userId,
      );

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _updateAddress(
    UpdateAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(AddressLoading());

      await addressRepository.updateAddress(event.address);

      final addresses = await addressRepository.getAddresses(
        event.address.userId,
      );

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _deleteAddress(
    DeleteAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(AddressLoading());

      await addressRepository.deleteAddress(event.id);

      final addresses = await addressRepository.getAddresses(event.userId);

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _setDefaultAddress(
    SetDefaultAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      emit(AddressLoading());

      await addressRepository.setDefaultAddress(event.userId, event.addressId);

      final addresses = await addressRepository.getAddresses(event.userId);

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
