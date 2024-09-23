// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_archive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderArchiveModelAdapter extends TypeAdapter<OrderArchiveModel> {
  @override
  final int typeId = 3;

  @override
  OrderArchiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderArchiveModel(
      image: fields[0] as Uint8List?,
      name_of_the_picture: fields[1] as String?,
      date_of_delivery: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderArchiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name_of_the_picture)
      ..writeByte(2)
      ..write(obj.date_of_delivery);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderArchiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
