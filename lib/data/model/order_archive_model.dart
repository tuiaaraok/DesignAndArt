import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'order_archive_model.g.dart';

@HiveType(typeId: 3)
class OrderArchiveModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? name_of_the_picture;
  @HiveField(2)
  String? date_of_delivery;
  OrderArchiveModel(
      {this.image, this.name_of_the_picture, this.date_of_delivery});
}
