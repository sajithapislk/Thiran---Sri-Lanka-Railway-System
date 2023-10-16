// To parse this JSON data, do
//
//     final stationModel = stationModelFromJson(jsonString);

import 'dart:convert';

List<StationModel> stationModelFromJson(String str) => List<StationModel>.from(json.decode(str).map((x) => StationModel.fromJson(x)));

String stationModelToJson(List<StationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StationModel {
  int id;
  String name;
  String address;
  String tp;
  int leftSlide;
  int rightSlide;
  dynamic createdAt;
  dynamic updatedAt;

  StationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.tp,
    required this.leftSlide,
    required this.rightSlide,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    tp: json["tp"],
    leftSlide: json["left_slide"],
    rightSlide: json["right_slide"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "tp": tp,
    "left_slide": leftSlide,
    "right_slide": rightSlide,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
