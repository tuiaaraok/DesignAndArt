// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_an_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAnOrderModelAdapter extends TypeAdapter<PlaceAnOrderModel> {
  @override
  final int typeId = 1;

  @override
  PlaceAnOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceAnOrderModel(
      image: fields[0] as Uint8List?,
      name_of_the_picture: fields[1] as String?,
      date_of_delivery: fields[2] as String?,
      note: fields[3] as String?,
      isComlete: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceAnOrderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name_of_the_picture)
      ..writeByte(2)
      ..write(obj.date_of_delivery)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.isComlete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAnOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
