import 'package:madar_booking/models/Driver.dart';

class Media {
  String url;
  String thumb;
  Type type;
  String id;

  Media({
    this.url,
    this.thumb,
    this.type,
    this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
        url: json["url"] == null ? null : json["url"],
        thumb: json["thumb"] == null ? null : json["thumb"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "thumb": thumb == null ? null : thumb,
        "type": type == null ? null : typeValues.reverse[type],
        "id": id == null ? null : id,
      };
}
