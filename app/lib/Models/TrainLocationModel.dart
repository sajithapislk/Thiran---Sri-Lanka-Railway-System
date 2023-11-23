// To parse this JSON data, do
//
//     final trainLocationModel = trainLocationModelFromJson(jsonString);

import 'dart:convert';

TrainLocationModel trainLocationModelFromJson(String str) => TrainLocationModel.fromJson(json.decode(str));

String trainLocationModelToJson(TrainLocationModel data) => json.encode(data.toJson());

class TrainLocationModel {
  int id;
  int stId;
  String latitude;
  String longitude;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  TrainLocationModel({
    required this.id,
    required this.stId,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainLocationModel.fromJson(Map<String, dynamic> json) => TrainLocationModel(
    id: json["id"],
    stId: json["st_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "st_id": stId,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
