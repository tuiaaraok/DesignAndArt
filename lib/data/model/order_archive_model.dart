import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'order_archive_model.g.dart';

@HiveType(typeId: 3)
class OrderArchiveModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? nameOfThePicture;
  @HiveField(2)
  String? dateOfDelivery;
  OrderArchiveModel({this.image, this.nameOfThePicture, this.dateOfDelivery});
}
