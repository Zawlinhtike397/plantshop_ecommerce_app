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
      discountAmount: (fields[1] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, AppliedCouponModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.discountAmount);
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
