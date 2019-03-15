import 'package:madar_booking/models/Location.dart';

class Airport {
  String nameEn;
  String nameAr;
  String nameTr;
  String status;
  String id;
  String locationId;
  Location location;

  Airport({
    this.nameEn,
    this.nameAr,
    this.nameTr,
    this.status,
    this.id,
    this.locationId,
    this.location,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => new Airport(
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        nameAr: json["nameAr"] == null ? null : json["nameAr"],
        nameTr: json["nameTr"] == null ? null : json["nameTr"],
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "nameEn": nameEn == null ? null : nameEn,
        "nameAr": nameAr == null ? null : nameAr,
        "nameTr": nameTr == null ? null : nameTr,
        "status": status == null ? null : status,
        "id": id == null ? null : id,
        "locationId": locationId == null ? null : locationId,
        "location": location == null ? null : location.toJson(),
      };
}
