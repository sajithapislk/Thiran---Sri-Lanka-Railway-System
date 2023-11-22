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
  String longitude;
  String latitude;
  DateTime createdAt;
  DateTime updatedAt;

  StationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.tp,
    required this.leftSlide,
    required this.rightSlide,
    required this.longitude,
    required this.latitude,
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
    longitude: json["longitude"],
    latitude: json["latitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "tp": tp,
    "left_slide": leftSlide,
    "right_slide": rightSlide,
    "longitude": longitude,
    "latitude": latitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
