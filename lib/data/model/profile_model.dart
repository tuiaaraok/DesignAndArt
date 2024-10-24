import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 2)
class ProfileModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? nameOfThePicture;
  @HiveField(2)
  String? note;
  ProfileModel({this.image, this.nameOfThePicture, this.note});
}
