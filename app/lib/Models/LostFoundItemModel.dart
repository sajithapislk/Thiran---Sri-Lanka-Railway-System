// To parse this JSON data, do
//
//     final lostFoundItemModel = lostFoundItemModelFromJson(jsonString);

import 'dart:convert';

List<LostFoundItemModel> lostFoundItemModelFromJson(String str) => List<LostFoundItemModel>.from(json.decode(str).map((x) => LostFoundItemModel.fromJson(x)));

String lostFoundItemModelToJson(List<LostFoundItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LostFoundItemModel {
  int id;
  String uId;
  String type;
  String itemName;
  String description;
  dynamic img1;
  dynamic img2;
  dynamic img3;
  dynamic img4;
  dynamic isSubmitStation;
  dynamic stationId;
  dynamic officerId;
  dynamic isRelease;
  dynamic releaseInfo;
  dynamic releaseTp;
  dynamic createdAt;
  dynamic updatedAt;

  LostFoundItemModel({
    required this.id,
    required this.uId,
    required this.type,
    required this.itemName,
    required this.description,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.isSubmitStation,
    required this.stationId,
    required this.officerId,
    required this.isRelease,
    required this.releaseInfo,
    required this.releaseTp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LostFoundItemModel.fromJson(Map<String, dynamic> json) => LostFoundItemModel(
    id: json["id"],
    uId: json["u_id"],
    type: json["type"],
    itemName: json["item_name"],
    description: json["description"],
    img1: json["img1"],
    img2: json["img2"],
    img3: json["img3"],
    img4: json["img4"],
    isSubmitStation: json["is_submit_station"],
    stationId: json["station_id"],
    officerId: json["officer_id"],
    isRelease: json["is_release"],
    releaseInfo: json["release_info"],
    releaseTp: json["release_tp"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "u_id": uId,
    "type": type,
    "item_name": itemName,
    "description": description,
    "img1": img1,
    "img2": img2,
    "img3": img3,
    "img4": img4,
    "is_submit_station": isSubmitStation,
    "station_id": stationId,
    "officer_id": officerId,
    "is_release": isRelease,
    "release_info": releaseInfo,
    "release_tp": releaseTp,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
