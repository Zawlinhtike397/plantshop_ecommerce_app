import 'package:hive_ce/hive_ce.dart';

part 'applied_cupon_model.g.dart';

@HiveType(typeId: 1)
class AppliedCouponModel extends HiveObject {
  @HiveField(0)
  final String code;

  @HiveField(1)
  final double discountAmount;

  AppliedCouponModel({required this.code, required this.discountAmount});
}
