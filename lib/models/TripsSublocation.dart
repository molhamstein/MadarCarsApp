class TripSublocation {
  int duration;
  String id;
  String predefinedTripId;
  String subLocationId;
  String name;

  TripSublocation({
    this.duration,
    this.id,
    this.predefinedTripId,
    this.subLocationId,
    this.name,
  });

  factory TripSublocation.fromJson(Map<String, dynamic> json) =>
      new TripSublocation(
        duration: json["duration"] == null ? null : json["duration"],
        id: json["id"] == null ? null : json["id"],
        predefinedTripId:
            json["predefinedTripId"] == null ? null : json["predefinedTripId"],
        subLocationId:
            json["subLocationId"] == null ? null : json["subLocationId"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration == null ? null : duration,
        "id": id == null ? null : id,
        "predefinedTripId": predefinedTripId == null ? null : predefinedTripId,
        "subLocationId": subLocationId == null ? null : subLocationId,
        "name": name == null ? null : name,
      };
}
