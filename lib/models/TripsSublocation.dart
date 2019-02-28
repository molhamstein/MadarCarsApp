import 'package:madar_booking/models/Car.dart';

class TripSublocation {

  String id;
  int cost;
  String subLocationId;
  SubLocation subLocation;
  int duration;
  String tripId;


  Map<String, dynamic> toJson() => {
    "duration": duration == null ? null : duration,
    "cost": cost == null ? null : cost,
    "id": id == null ? null : id,
    "tripId": tripId == null ? null : tripId,
    "subLocationId": subLocationId == null ? null : subLocationId,
    "subLocation": subLocation == null ? null : subLocation.toJson(),
  };

  TripSublocation({
    this.duration,
    this.cost,
    this.id,
    this.tripId,
    this.subLocationId,
    this.subLocation,
  });



  @override
  String toString() {
    return 'TripSublocation{duration: $duration, cost: $cost, id: $id, tripId: $tripId, sublocationId: $subLocationId, subLocation: $subLocation}';
  }


  factory TripSublocation.fromJson(Map<String, dynamic> json) =>
      new TripSublocation(
        duration: json["duration"] == null ? null : json["duration"],
        cost: json["cost"] == null ? null : json["cost"],
        id: json["id"] == null ? null : json["id"],
        tripId: json["tripId"] == null ? null : json["tripId"],
        subLocationId:
        json["subLocationId"] == null ? null : json["subLocationId"],
        subLocation: json["subLocation"] == null
            ? null
            : SubLocation.fromJson(json["subLocation"]),
      );



}
