
import 'package:madar_booking/models/Country.dart';
import 'package:madar_booking/models/media.dart';

class TravelAgency {
  String nameEn;
  String nameAr;
  String nameTr;
  String phoneNumber;
  String status;
  String createdAt;
  String email;
  String id;
  String isoCode;
  String mediaId;
  Country country;
  Media media;

  TravelAgency({
    this.nameEn,
    this.nameAr,
    this.nameTr,
    this.phoneNumber,
    this.status,
    this.createdAt,
    this.email,
    this.id,
    this.isoCode,
    this.mediaId,
    this.country,
    this.media,
  });

  factory TravelAgency.fromJson(Map<String, dynamic> json) => new TravelAgency(
    nameEn: json["nameEn"],
    nameAr: json["nameAr"],
    nameTr: json["nameTr"],
    phoneNumber: json["phoneNumber"],
    status: json["status"],
    createdAt: json["createdAt"],
    email: json["email"],
    id: json["id"],
    isoCode: json["ISOCode"],
    mediaId: json["mediaId"],
    country: Country.fromJson(json["country"]),
    media: Media.fromJson(json["media"]),
  );

  Map<String, dynamic> toJson() => {
    "nameEn": nameEn,
    "nameAr": nameAr,
    "nameTr": nameTr,
    "phoneNumber": phoneNumber,
    "status": status,
    "createdAt": createdAt,
    "email": email,
    "id": id,
    "ISOCode": isoCode,
    "mediaId": mediaId,
    "country": country.toJson(),
    "media": media.toJson(),
  };
}
