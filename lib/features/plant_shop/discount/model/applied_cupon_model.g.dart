// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_cupon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppliedCouponModelAdapter extends TypeAdapter<AppliedCouponModel> {
  @override
  final typeId = 1;

  @override
  AppliedCouponModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppliedCouponModel(
      code: fields[0] as String,
      percentage: (fields[2] as num).toDouble(),
      minAmount: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, AppliedCouponModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.percentage)
      ..writeByte(3)
      ..write(obj.minAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppliedCouponModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
