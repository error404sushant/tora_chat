// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinDetailAdapter extends TypeAdapter<CoinDetail> {
  @override
  final int typeId = 0;

  @override
  CoinDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinDetail(
      symbol: fields[0] as String?,
      name: fields[1] as String?,
      price: fields[2] as String?,
      about: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CoinDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.about)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
