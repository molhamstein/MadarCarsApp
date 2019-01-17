// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';
import 'location.dart';
import 'Image.dart';
import 'TripsSublocation.dart';

List<TripModel> tripFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<TripModel>.from(jsonData.map((x) => TripModel.fromJson(x)));
}

String tripToJson(List<TripModel> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class TripModel {
  String createdAt;
  int duration;
  String status;
  String titleEn;
  String titleAr;
  String titleTr;
  String descriptionEn;
  String descriptionAr;
  String descriptionTr;
  String id;
  String locationId;
  String mediaId;
  List<dynamic> predefinedTripsMedias;
  String color1;
  String color2;
  Media media;
  Location location;
  List<dynamic> predefinedTripsMedia;
  List<TripSublocation> predefinedTripsSublocations;

  TripModel({
    this.createdAt,
    this.duration,
    this.status,
    this.titleEn,
    this.titleAr,
    this.titleTr,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionTr,
    this.id,
    this.locationId,
    this.mediaId,
    this.predefinedTripsMedias,
    this.color1,
    this.color2,
    this.media,
    this.location,
    this.predefinedTripsMedia,
    this.predefinedTripsSublocations,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => new TripModel(
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        duration: json["duration"] == null ? null : json["duration"],
        status: json["status"] == null ? null : json["status"],
        titleEn: json["titleEn"] == null ? null : json["titleEn"],
        titleAr: json["titleAr"] == null ? null : json["titleAr"],
        titleTr: json["titleTr"] == null ? null : json["titleTr"],
        descriptionEn:
            json["descriptionEn"] == null ? null : json["descriptionEn"],
        descriptionAr:
            json["descriptionAr"] == null ? null : json["descriptionAr"],
        descriptionTr:
            json["descriptionTr"] == null ? null : json["descriptionTr"],
        id: json["id"] == null ? null : json["id"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        predefinedTripsMedias: json["predefinedTripsMedias"] == null
            ? null
            : new List<dynamic>.from(
                json["predefinedTripsMedias"].map((x) => x)),
        color1: json["color1"] == null ? null : json["color1"],
        color2: json["color2"] == null ? null : json["color2"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        predefinedTripsMedia: json["predefinedTripsMedia"] == null
            ? null
            : new List<dynamic>.from(
                json["predefinedTripsMedia"].map((x) => x)),
        predefinedTripsSublocations: json["predefinedTripsSublocations"] == null
            ? null
            : new List<TripSublocation>.from(json["predefinedTripsSublocations"]
                .map((x) => TripSublocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt,
        "duration": duration == null ? null : duration,
        "status": status == null ? null : status,
        "titleEn": titleEn == null ? null : titleEn,
        "titleAr": titleAr == null ? null : titleAr,
        "titleTr": titleTr == null ? null : titleTr,
        "descriptionEn": descriptionEn == null ? null : descriptionEn,
        "descriptionAr": descriptionAr == null ? null : descriptionAr,
        "descriptionTr": descriptionTr == null ? null : descriptionTr,
        "id": id == null ? null : id,
        "locationId": locationId == null ? null : locationId,
        "mediaId": mediaId == null ? null : mediaId,
        "predefinedTripsMedias": predefinedTripsMedias == null
            ? null
            : new List<dynamic>.from(predefinedTripsMedias.map((x) => x)),
        "color1": color1 == null ? null : color1,
        "color2": color2 == null ? null : color2,
        "media": media == null ? null : media.toJson(),
        "location": location == null ? null : location.toJson(),
        "predefinedTripsMedia": predefinedTripsMedia == null
            ? null
            : new List<dynamic>.from(predefinedTripsMedia.map((x) => x)),
        "predefinedTripsSublocations": predefinedTripsSublocations == null
            ? null
            : new List<dynamic>.from(
                predefinedTripsSublocations.map((x) => x.toJson())),
      };
}
