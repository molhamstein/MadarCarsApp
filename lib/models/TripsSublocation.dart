import 'package:madar_booking/models/Car.dart';

class TripSublocation {
  int duration;
  int cost;
  String id;
  String tripId;
  String sublocationId;
  SubLocation subLocation;

  TripSublocation({
    this.duration,
    this.cost,
    this.id,
    this.tripId,
    this.sublocationId,
    this.subLocation,
  });

  factory TripSublocation.fromJson(Map<String, dynamic> json) =>
      new TripSublocation(
        duration: json["duration"] == null ? null : json["duration"],
        cost: json["cost"] == null ? null : json["cost"],
        id: json["id"] == null ? null : json["id"],
        tripId: json["tripId"] == null ? null : json["tripId"],
        sublocationId:
            json["sublocationId"] == null ? null : json["sublocationId"],
        subLocation: json["subLocation"] == null
            ? null
            : SubLocation.fromJson(json["subLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration == null ? null : duration,
        "cost": cost == null ? null : cost,
        "id": id == null ? null : id,
        "tripId": tripId == null ? null : tripId,
        "sublocationId": sublocationId == null ? null : sublocationId,
        "subLocation": subLocation == null ? null : subLocation.toJson(),
      };
}
