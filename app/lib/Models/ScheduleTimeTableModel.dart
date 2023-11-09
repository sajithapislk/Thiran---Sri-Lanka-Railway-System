// To parse this JSON data, do
//
//     final scheduleTimeTableModel = scheduleTimeTableModelFromJson(jsonString);

import 'dart:convert';

ScheduleTimeTableModel scheduleTimeTableModelFromJson(String str) => ScheduleTimeTableModel.fromJson(json.decode(str));

String scheduleTimeTableModelToJson(ScheduleTimeTableModel data) => json.encode(data.toJson());

class ScheduleTimeTableModel {
  double distance;
  Price price;
  List<Schedule> schedules;

  ScheduleTimeTableModel({
    required this.distance,
    required this.price,
    required this.schedules,
  });

  factory ScheduleTimeTableModel.fromJson(Map<String, dynamic> json) => ScheduleTimeTableModel(
    distance: double.parse(json["distance"].toString()),
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
  int id;
  int beyond;
  int above;
  double acsPrice;
  double osPrice;
  double scrsPrice;
  double tcrsPrice;
  DateTime createdAt;
  DateTime updatedAt;

  Price({
    required this.id,
    required this.beyond,
    required this.above,
    required this.acsPrice,
    required this.osPrice,
    required this.scrsPrice,
    required this.tcrsPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    id: json["id"],
    beyond: json["beyond"],
    above: json["above"],
    acsPrice: double.parse(json["acs_price"].toString()),
    osPrice: double.parse(json["os_price"].toString()),
    scrsPrice: double.parse(json["scrs_price"].toString()),
    tcrsPrice: double.parse(json["tcrs_price"].toString()),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "beyond": beyond,
    "above": above,
    "acs_price": acsPrice,
    "os_price": osPrice,
    "scrs_price": scrsPrice,
    "tcrs_price": tcrsPrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
  Train train;

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
    required this.train,
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
    train: Train.fromJson(json["train"]),
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
    "train": train.toJson(),
  };
}

class Route {
  int id;
  String name;
  String direction;
  List<int> stationList;
  dynamic createdAt;
  dynamic updatedAt;

  Route({
    required this.id,
    required this.name,
    required this.direction,
    required this.stationList,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    name: json["name"],
    direction: json["direction"],
    stationList: List<int>.from(json["station_list"].map((x) => x)),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "direction": direction,
    "station_list": List<dynamic>.from(stationList.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Train {
  int id;
  String name;
  String no;
  int acsMaxSeats;
  int osMaxSeats;
  int scrsMaxSeats;
  int tcrsMaxSeats;
  dynamic createdAt;
  dynamic updatedAt;

  Train({
    required this.id,
    required this.name,
    required this.no,
    required this.acsMaxSeats,
    required this.osMaxSeats,
    required this.scrsMaxSeats,
    required this.tcrsMaxSeats,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Train.fromJson(Map<String, dynamic> json) => Train(
    id: json["id"],
    name: json["name"],
    no: json["no"],
    acsMaxSeats: json["acs_max_seats"],
    osMaxSeats: json["os_max_seats"],
    scrsMaxSeats: json["scrs_max_seats"],
    tcrsMaxSeats: json["tcrs_max_seats"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "no": no,
    "acs_max_seats": acsMaxSeats,
    "os_max_seats": osMaxSeats,
    "scrs_max_seats": scrsMaxSeats,
    "tcrs_max_seats": tcrsMaxSeats,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
