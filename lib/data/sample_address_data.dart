import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

List<AddressModel> getSampleAddresses() {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    throw Exception("User not logged in");
  }

  return [
    AddressModel(
      userId: user.id,
      contactName: 'Home',
      phone: '0911111111',
      homeNo: '12A',
      street: 'Shwe Pyi Thar',
      city: 'Yangon',
      isDefault: true,
    ),
    AddressModel(
      userId: user.id,
      contactName: 'Work',
      phone: '0922222222',
      homeNo: '221B',
      street: 'Chan Aye Thar Zan',
      city: 'Mandalay',
    ),
    AddressModel(
      userId: user.id,
      contactName: 'Gym',
      phone: '0933333333',
      homeNo: '255B',
      street: 'Hlaing Bwar',
      city: 'Monywa',
    ),
  ];
}
