import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'place_an_order_model.g.dart';

@HiveType(typeId: 1)
class PlaceAnOrderModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? name_of_the_picture;
  @HiveField(2)
  String? date_of_delivery;
  @HiveField(3)
  String? note;
  @HiveField(4)
  bool? isComlete;
  PlaceAnOrderModel(
      {this.image,
      this.name_of_the_picture,
      this.date_of_delivery,
      this.note,
      this.isComlete});
}
