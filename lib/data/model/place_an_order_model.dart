import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'place_an_order_model.g.dart';

@HiveType(typeId: 1)
class PlaceAnOrderModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? nameOfThePicture;
  @HiveField(2)
  String? dateOfDelivery;
  @HiveField(3)
  String? note;
  @HiveField(4)
  bool? isComlete;
  PlaceAnOrderModel(
      {this.image,
      this.nameOfThePicture,
      this.dateOfDelivery,
      this.note,
      this.isComlete});
}
