import 'dart:ui';

import 'package:madar_booking/models/Airport.dart';
import 'package:madar_booking/models/media.dart';


class SubLocationfromLocation {
  String nameEn;
  String nameAr;
  String nameTr;
  String status;
  String color1;
  String color2;
  String createdAt;
  String id;
  String locationId;
  String mediaId;
  Media media;
  Location location;

  SubLocationfromLocation({
    this.nameEn,
    this.nameAr,
    this.nameTr,
    this.status,
    this.color1,
    this.color2,
    this.createdAt,
    this.id,
    this.locationId,
    this.mediaId,
    this.media,
    this.location,
  });

  factory SubLocationfromLocation.fromJson(Map<String, dynamic> json) => new SubLocationfromLocation(
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    nameAr: json["nameAr"] == null ? null : json["nameAr"],
    nameTr: json["nameTr"] == null ? null : json["nameTr"],
    status: json["status"] == null ? null : json["status"],
    color1: json["color1"] == null ? null : json["color1"],
    color2: json["color2"] == null ? null : json["color2"],
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
    id: json["id"] == null ? null : json["id"],
    locationId: json["locationId"] == null ? null : json["locationId"],
    mediaId: json["mediaId"] == null ? null : json["mediaId"],
    media: json["media"] == null ? null : Media.fromJson(json["media"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "nameEn": nameEn == null ? null : nameEn,
    "nameAr": nameAr == null ? null : nameAr,
    "nameTr": nameTr == null ? null : nameTr,
    "status": status == null ? null : status,
    "color1": color1 == null ? null : color1,
    "color2": color2 == null ? null : color2,
    "createdAt": createdAt == null ? null : createdAt,
    "id": id == null ? null : id,
    "locationId": locationId == null ? null : locationId,
    "mediaId": mediaId == null ? null : mediaId,
    "media": media == null ? null : media.toJson(),
    "location": location == null ? null : location.toJson(),
  };
}




class   Location {
  String descriptionEn;
  String descriptionAr;
  String descriptionTr;
  String nameEn;
  String nameAr;
  String nameTr;
  String color1;
  String color2;
  String status;
  String createdAt;
  String id;
  String mediaId;
  Media media;
  List<dynamic> slideMedia;
  List<String> subLocationsIds;
  List<Airport> airports;
  String locationId ;
  List <Location> subLocations ;


  Location({
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionTr,
    this.nameEn,
    this.nameAr,
    this.nameTr,
    this.color1,
    this.color2,
    this.status,
    this.createdAt,
    this.id,
    this.mediaId,
    this.media,
    this.slideMedia,
    this.subLocationsIds,
    this.airports,
    this.locationId,
    this.subLocations
  });

  factory Location.fromJson(Map<String, dynamic> json) => new Location(
        descriptionEn:
            json["descriptionEn"] == null ? null : json["descriptionEn"],
        descriptionAr:
            json["descriptionAr"] == null ? null : json["descriptionAr"],
        descriptionTr:
            json["descriptionTr"] == null ? null : json["descriptionTr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        nameAr: json["nameAr"] == null ? null : json["nameAr"],
        nameTr: json["nameTr"] == null ? null : json["nameTr"],
        color1: json["color1"] == null ? null : json["color1"],
        color2: json["color2"] == null ? null : json["color2"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        slideMedia: json["slideMedia"] == null
            ? null
            : new List<dynamic>.from(json["slideMedia"].map((x) => x)),
        subLocationsIds: json['subLocations'] == null
            ? null
            : (json['subLocations'] as List)
                .map((jsonSubLocation) => jsonSubLocation['id'].toString())
                .toList(),
        airports: json["airports"] == null
            ? null
            : new List<Airport>.from(
                json["airports"].map((x) => Airport.fromJson(x))),
            locationId: json["locationId"]==null ?null :json["locationId"],
    subLocations: json["subLocations"] == null
        ? null
        : new List<Location>.from(
        json["subLocations"].map((x) => Location.fromJson(x))),


      );

  Map<String, dynamic> toJson() => {
        "descriptionEn": descriptionEn == null ? null : descriptionEn,
        "descriptionAr": descriptionAr == null ? null : descriptionAr,
        "descriptionTr": descriptionTr == null ? null : descriptionTr,
        "nameEn": nameEn == null ? null : nameEn,
        "nameAr": nameAr == null ? null : nameAr,
        "nameTr": nameTr == null ? null : nameTr,
        "color1": color1 == null ? null : color1,
        "color2": color2 == null ? null : color2,
        "status": status == null ? null : status,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "mediaId": mediaId == null ? null : mediaId,
        "media": media == null ? null : media.toJson(),
        "slideMedia": slideMedia == null
            ? null
            : new List<dynamic>.from(slideMedia.map((x) => x)),
        "airports": airports == null
            ? null
            : new List<dynamic>.from(airports.map((x) => x.toJson())),
      };



 sub(){
   Location location;
   print(location.subLocations);
 }


  String name(Locale locale) {
    if (locale.languageCode == 'en') {
      return nameEn;
    }
    return nameAr;
  }

  String description(Locale locale) {
    if (locale.languageCode == 'en') {
      return descriptionEn;
    }
    return descriptionAr;
  }

//  @override
//  String toString() {
//    return 'Location{subLocationsIds: $subLocationsIds}';
//  }
}

class LocationsResponse {
  final List<Location> locations;

  LocationsResponse(this.locations);

  factory LocationsResponse.fromJson(List<dynamic> json) {
    return LocationsResponse(
        json.map((jsonLocation) => Location.fromJson(jsonLocation)).toList());
  }

}
