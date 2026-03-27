import 'package:plantify_plantshop_project/data/sample_data.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiscountRepository {
  final _supabase = Supabase.instance.client;

  Future<void> uploadDiscounts() async {
    for (var json in discounts) {
      try {
        final discount = DiscountModel.fromJson(json);
        final jsonData = discount.toJson();

        await _supabase.from('discounts').upsert(jsonData);
      } catch (e) {
        print('Error uploading discount ${json['id']}: $e');
        rethrow;
      }
    }
  }

  Future<List<DiscountModel>> fetchDiscounts() async {
    try {
      final response = await _supabase
          .from('discounts')
          .select()
          .order('id', ascending: true);

      final data = response as List<dynamic>;

      return data.map((json) => DiscountModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch discounts: $e');
    }
  }

  Future<DiscountModel?> getDiscountByCode(String code) async {
    final response = await _supabase
        .from('discounts')
        .select()
        .eq('code', code)
        .maybeSingle();

    if (response == null) return null;

    return DiscountModel.fromJson(response);
  }

  Future<bool> hasUserUsedCoupon({
    required String userId,
    required String code,
  }) async {
    final response = await _supabase
        .from('user_coupon_usage')
        .select()
        .eq('user_id', userId)
        .eq('cupon_code', code);

    return response.isNotEmpty;
  }

  Future<bool> hasUserUsedAnyCoupon(String userId) async {
    final response = await _supabase
        .from('user_coupon_usage')
        .select()
        .eq('user_id', userId);

    return response.isNotEmpty;
  } //temporary

  Future<void> saveCouponUsage({
    required String userId,
    required String code,
  }) async {
    await _supabase.from('user_coupon_usage').insert({
      'user_id': userId,
      'cupon_code': code,
    });
  }
}
