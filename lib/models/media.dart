import 'dart:convert';

List<Media> mediasFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Media>.from(jsonData.map((x) => Media.fromJson(x)));
}

String mediaToJson(List<Media> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Media {
  String url;
  String thumb;
  String type;
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
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "thumb": thumb == null ? null : thumb,
        "type": type == null ? null : type,
        "id": id == null ? null : id,
      };
}
