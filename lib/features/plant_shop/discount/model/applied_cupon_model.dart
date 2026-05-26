import 'package:hive_ce/hive_ce.dart';

part 'applied_cupon_model.g.dart';

@HiveType(typeId: 1)
class AppliedCouponModel extends HiveObject {
  @HiveField(0)
  final String code;

  @HiveField(2)
  final double percentage;

  @HiveField(3)
  final int? minAmount;

  AppliedCouponModel({
    required this.code,
    required this.percentage,
    this.minAmount,
  });
}
