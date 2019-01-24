import 'package:madar_booking/models/media.dart';

import 'Country.dart';

class User {
  static const ID = 'id';
  static const USER_NAME = 'name';
  static const PHONE_NUMBER = 'phoneNumber';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  String name;
  String phoneNumber;
  String status;
  bool registrationCompleted;
  String createdAt;
  String typeLogIn;
  String id;
  String isoCode;
  String mediaId;
  Country country;
  Media media;

  User({
    this.name,
    this.phoneNumber,
    this.status,
    this.registrationCompleted,
    this.createdAt,
    this.typeLogIn,
    this.id,
    this.isoCode,
    this.mediaId,
    this.country,
    this.media,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        status: json["status"] == null ? null : json["status"],
        registrationCompleted: json["registrationCompleted"] == null
            ? null
            : json["registrationCompleted"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        typeLogIn: json["typeLogIn"] == null ? null : json["typeLogIn"],
        id: json["id"] == null ? null : json["id"],
        isoCode: json["ISOCode"] == null ? null : json["ISOCode"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "status": status == null ? null : status,
        "registrationCompleted":
            registrationCompleted == null ? null : registrationCompleted,
        "createdAt": createdAt == null ? null : createdAt,
        "typeLogIn": typeLogIn == null ? null : typeLogIn,
        "id": id == null ? null : id,
        "ISOCode": isoCode == null ? null : isoCode,
        "mediaId": mediaId == null ? null : mediaId,
        "country": country == null ? null : country.toJson(),
        "media": media == null ? null : media.toJson(),
      };
}
