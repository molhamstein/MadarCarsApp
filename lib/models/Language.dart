class Language {
  String name;
  String code;
  String id;

  Language({
    this.name,
    this.code,
    this.id,
  });

  factory Language.fromJson(Map<String, dynamic> json) => new Language(
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "id": id == null ? null : id,
      };
}
