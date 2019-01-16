import 'package:madar_booking/models/Language.dart';

class DriverLang {
  String id;
  String driverId;
  String landuageId;
  Language language;

  DriverLang({
    this.id,
    this.driverId,
    this.landuageId,
    this.language,
  });

  factory DriverLang.fromJson(Map<String, dynamic> json) => new DriverLang(
        id: json["id"] == null ? null : json["id"],
        driverId: json["driverId"] == null ? null : json["driverId"],
        landuageId: json["landuageId"] == null ? null : json["landuageId"],
        language: json["language"] == null
            ? null
            : Language.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "driverId": driverId == null ? null : driverId,
        "landuageId": landuageId == null ? null : landuageId,
        "language": language == null ? null : language.toJson(),
      };
}
