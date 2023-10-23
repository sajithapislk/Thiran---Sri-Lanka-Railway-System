// To parse this JSON data, do
//
//     final scheduleTimeTableModel = scheduleTimeTableModelFromJson(jsonString);

import 'dart:convert';

ScheduleTimeTableModel scheduleTimeTableModelFromJson(String str) => ScheduleTimeTableModel.fromJson(json.decode(str));

String scheduleTimeTableModelToJson(ScheduleTimeTableModel data) => json.encode(data.toJson());

class ScheduleTimeTableModel {
  int distance;
  Price price;
  List<Schedule> schedules;

  ScheduleTimeTableModel({
    required this.distance,
    required this.price,
    required this.schedules,
  });

  factory ScheduleTimeTableModel.fromJson(Map<String, dynamic> json) => ScheduleTimeTableModel(
    distance: json["distance"],
    price: Price.fromJson(json["price"]),
    schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "price": price.toJson(),
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
  };
}

class Price {
  int? id;
  int? beyond;
  int? above;
  int? acsPrice;
  int? osPrice;
  int? scrsPrice;
  int? tcrsPrice;
  dynamic? createdAt;
  dynamic? updatedAt;

  Price({
    this.id,
    this.beyond,
    this.above,
    this.acsPrice,
    this.osPrice,
    this.scrsPrice,
    this.tcrsPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    id: json["id"],
    beyond: json["beyond"],
    above: json["above"],
    acsPrice: json["acs_price"],
    osPrice: json["os_price"],
    scrsPrice: json["scrs_price"],
    tcrsPrice: json["tcrs_price"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "beyond": beyond,
    "above": above,
    "acs_price": acsPrice,
    "os_price": osPrice,
    "scrs_price": scrsPrice,
    "tcrs_price": tcrsPrice,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Schedule {
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

  Schedule({
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

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
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
  String direction;
  dynamic createdAt;
  dynamic updatedAt;

  Route({
    required this.id,
    required this.trainId,
    required this.name,
    required this.stationList,
    required this.direction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    trainId: json["train_id"],
    name: json["name"],
    stationList: List<int>.from(json["station_list"].map((x) => x)),
    direction: json["direction"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "train_id": trainId,
    "name": name,
    "station_list": List<dynamic>.from(stationList.map((x) => x)),
    "direction": direction,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
