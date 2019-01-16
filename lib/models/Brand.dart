class Brand {
  String nameEn;
  String nameAr;
  String createdAt;
  String id;

  Brand({
    this.nameEn,
    this.nameAr,
    this.createdAt,
    this.id,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => new Brand(
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        nameAr: json["nameAr"] == null ? null : json["nameAr"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nameEn": nameEn == null ? null : nameEn,
        "nameAr": nameAr == null ? null : nameAr,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
      };
}
