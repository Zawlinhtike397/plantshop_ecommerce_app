import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressRepository {
  final supabase = Supabase.instance.client;

  Future<void> uploadAddresses(List<AddressModel> addresses) async {
    final data = addresses.map((e) => e.toMap()).toList();

    await supabase.from('address').insert(data);
  }

  Future<List<AddressModel>> getAddresses(String userId) async {
    final response = await supabase
        .from('address')
        .select()
        .eq('user_id', userId)
        .order('is_default', ascending: false)
        .order('created_at', ascending: true);

    return response.map<AddressModel>((e) => AddressModel.fromMap(e)).toList();
  }

  Future<void> addAddress(AddressModel address) async {
    await supabase.from('address').insert(address.toMap());
  }

  Future<void> updateAddress(AddressModel address) async {
    await supabase
        .from('address')
        .update(address.toMap())
        .eq('id', address.id!);
  }

  Future<void> deleteAddress(String id) async {
    await supabase.from('address').delete().eq('id', id);
  }

  Future<void> setDefaultAddress(String userId, String selectedId) async {
    await supabase
        .from('address')
        .update({'is_default': false})
        .eq('user_id', userId);

    await supabase
        .from('address')
        .update({'is_default': true})
        .eq('id', selectedId);
  }
}
