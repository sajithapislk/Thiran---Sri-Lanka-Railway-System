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
  int leftDistance;
  int rightDistance;
  int leftTime;
  int rightTime;
  String longitude;
  String latitude;
  DateTime createdAt;
  DateTime updatedAt;

  StationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.tp,
    required this.leftDistance,
    required this.rightDistance,
    required this.leftTime,
    required this.rightTime,
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
    leftDistance: json["left_distance"],
    rightDistance: json["right_distance"],
    leftTime: json["left_time"],
    rightTime: json["right_time"],
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
    "left_distance": leftDistance,
    "right_distance": rightDistance,
    "left_time": leftTime,
    "right_time": rightTime,
    "longitude": longitude,
    "latitude": latitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
