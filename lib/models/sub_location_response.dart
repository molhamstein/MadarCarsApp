// To parse this JSON data, do
//
//     final subLocationResponse = subLocationResponseFromJson(jsonString);
import 'dart:convert';
import 'package:madar_booking/models/Car.dart';

SubLocationResponse subLocationResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return SubLocationResponse.fromJson(jsonData);
}

String subLocationResponseToJson(SubLocationResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class SubLocationResponse {
  int cost;
  String id;
  String carId;
  String subLocationId;
  SubLocation subLocation;

  SubLocationResponse({
    this.cost,
    this.id,
    this.carId,
    this.subLocationId,
    this.subLocation,
  });

  factory SubLocationResponse.fromJson(Map<String, dynamic> json) => new SubLocationResponse(
    cost: json["cost"],
    id: json["id"],
    carId: json["carId"],
    subLocationId: json["subLocationId"],
    subLocation: SubLocation.fromJson(json["subLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "cost": cost,
    "id": id,
    "carId": carId,
    "subLocationId": subLocationId,
    "subLocation": subLocation.toJson(),
  };
}
