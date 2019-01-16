class Location {
  final String description;
  final name;
  final String color1;
  final String color2;
  final List<String> subLocationsIds;

  Location(
    this.description,
    this.name,
    this.color1,
    this.color2,
    this.subLocationsIds,
  );
  factory Location.fromJson(Map<String, dynamic> json) {
    final subLocations = json['subLocations'] as List;

    return Location(
      json['descriptionEn'],
      json['nameEn'],
      json['color1'],
      json['color2'],
      subLocations.map((subLocationJson) => subLocationJson['id'].toString()).toList(),
    );
  }
}

class SubLocation {
  final String name;
  final String color1;
  final String color2;
  final String id;

  SubLocation(this.name, this.color1, this.color2, this.id);

  factory SubLocation.fromJson(Map<String, dynamic> json) {
    return SubLocation(
      json['nameEn'],
      json['color1'],
      json['color2'],
      json['id'],
    );
  }
}

class LocationsResponse {
  final List<Location> locations;

  LocationsResponse(this.locations);

  factory LocationsResponse.fromJson(List<dynamic> json) {

    return LocationsResponse(
        json.map((jsonLocation) => Location.fromJson(jsonLocation)).toList());
  }
}