// To parse this JSON data, do
//
//     final scheduleTimeTableModel = scheduleTimeTableModelFromJson(jsonString);

import 'dart:convert';

List<ScheduleTimeTableModel> scheduleTimeTableModelFromJson(String str) => List<ScheduleTimeTableModel>.from(json.decode(str).map((x) => ScheduleTimeTableModel.fromJson(x)));

String scheduleTimeTableModelToJson(List<ScheduleTimeTableModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleTimeTableModel {
  int id;
  int trainId;
  int routeId;
  DateTime startAt;
  DateTime endAt;
  String status;
  int acsPSeats;
  int osPSeats;
  int scrsPSeats;
  int tcrsPSeats;
  dynamic createdAt;
  dynamic updatedAt;
  Route route;

  ScheduleTimeTableModel({
    required this.id,
    required this.trainId,
    required this.routeId,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.acsPSeats,
    required this.osPSeats,
    required this.scrsPSeats,
    required this.tcrsPSeats,
    required this.createdAt,
    required this.updatedAt,
    required this.route,
  });

  factory ScheduleTimeTableModel.fromJson(Map<String, dynamic> json) => ScheduleTimeTableModel(
    id: json["id"],
    trainId: json["train_id"],
    routeId: json["route_id"],
    startAt: DateTime.parse(json["start_at"]),
    endAt: DateTime.parse(json["end_at"]),
    status: json["status"],
    acsPSeats: json["acs_p_seats"],
    osPSeats: json["os_p_seats"],
    scrsPSeats: json["scrs_p_seats"],
    tcrsPSeats: json["tcrs_p_seats"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    route: Route.fromJson(json["route"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "train_id": trainId,
    "route_id": routeId,
    "start_at": startAt.toIso8601String(),
    "end_at": endAt.toIso8601String(),
    "status": status,
    "acs_p_seats": acsPSeats,
    "os_p_seats": osPSeats,
    "scrs_p_seats": scrsPSeats,
    "tcrs_p_seats": tcrsPSeats,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "route": route.toJson(),
  };
}

class Route {
  int id;
  int trainId;
  String name;
  List<int> stationList;
  dynamic createdAt;
  dynamic updatedAt;

  Route({
    required this.id,
    required this.trainId,
    required this.name,
    required this.stationList,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    trainId: json["train_id"],
    name: json["name"],
    stationList: List<int>.from(json["station_list"].map((x) => x)),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "train_id": trainId,
    "name": name,
    "station_list": List<dynamic>.from(stationList.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
