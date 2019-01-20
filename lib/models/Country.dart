class Country {
  String isoCode;
  String name;

  Country({
    this.isoCode,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => new Country(
        isoCode: json["isoCode"] == null ? null : json["isoCode"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "isoCode": isoCode == null ? null : isoCode,
        "name": name == null ? null : name,
      };
}
