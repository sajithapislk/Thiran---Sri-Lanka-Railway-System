// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

List<BookModel> bookModelFromJson(String str) => List<BookModel>.from(json.decode(str).map((x) => BookModel.fromJson(x)));

String bookModelToJson(List<BookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookModel {
  int id;
  int uid;
  int stId;
  int paymentId;
  int fromSId;
  int toSId;
  int distance;
  String seatType;
  int nop;
  dynamic enteredAt;
  dynamic endedAt;
  dynamic isCanceled;
  dynamic createdAt;
  dynamic updatedAt;
  Payment payment;
  ScheduleTime scheduleTime;
  Station toStation;
  Station fromStation;

  BookModel({
    required this.id,
    required this.uid,
    required this.stId,
    required this.paymentId,
    required this.fromSId,
    required this.toSId,
    required this.distance,
    required this.seatType,
    required this.nop,
    required this.enteredAt,
    required this.endedAt,
    required this.isCanceled,
    required this.createdAt,
    required this.updatedAt,
    required this.payment,
    required this.scheduleTime,
    required this.toStation,
    required this.fromStation,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    uid: json["uid"],
    stId: json["st_id"],
    paymentId: json["payment_id"],
    fromSId: json["from_s_id"],
    toSId: json["to_s_id"],
    distance: json["distance"],
    seatType: json["seat_type"],
    nop: json["nop"],
    enteredAt: json["entered_at"],
    endedAt: json["ended_at"],
    isCanceled: json["is_canceled"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    payment: Payment.fromJson(json["payment"]),
    scheduleTime: ScheduleTime.fromJson(json["schedule_time"]),
    toStation: Station.fromJson(json["to_station"]),
    fromStation: Station.fromJson(json["from_station"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "st_id": stId,
    "payment_id": paymentId,
    "from_s_id": fromSId,
    "to_s_id": toSId,
    "distance": distance,
    "seat_type": seatType,
    "nop": nop,
    "entered_at": enteredAt,
    "ended_at": endedAt,
    "is_canceled": isCanceled,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "payment": payment.toJson(),
    "schedule_time": scheduleTime.toJson(),
    "to_station": toStation.toJson(),
    "from_station": fromStation.toJson(),
  };
}

class Station {
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

  Station({
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

  factory Station.fromJson(Map<String, dynamic> json) => Station(
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

class Payment {
  int id;
  String method;
  String status;
  int amount;
  String token;
  dynamic response;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Payment({
    required this.id,
    required this.method,
    required this.status,
    required this.amount,
    required this.token,
    required this.response,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    method: json["method"],
    status: json["status"],
    amount: json["amount"],
    token: json["token"],
    response: json["response"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method": method,
    "status": status,
    "amount": amount,
    "token": token,
    "response": response,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class ScheduleTime {
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
  DateTime createdAt;
  DateTime updatedAt;
  Train train;
  Route route;

  ScheduleTime({
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
    required this.train,
    required this.route,
  });

  factory ScheduleTime.fromJson(Map<String, dynamic> json) => ScheduleTime(
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    train: Train.fromJson(json["train"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "train": train.toJson(),
    "route": route.toJson(),
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
