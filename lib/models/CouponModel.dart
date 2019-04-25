class Coupon {
  String code;
  String from;
  String to;
  String status;
  int numberOfUses;
  int numberOfUsed;
  int value;
  String type;
  String createdAt;
  String id;
  String travelAgencyId;

  Coupon({
    this.code,
    this.from,
    this.to,
    this.status,
    this.numberOfUses,
    this.numberOfUsed,
    this.value,
    this.type,
    this.createdAt,
    this.id,
    this.travelAgencyId,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => new Coupon(
        code: json["code"],
        from: json["from"],
        to: json["to"],
        status: json["status"],
        numberOfUses: json["numberOfUses"],
        numberOfUsed: json["numberOfUsed"],
        value: json["value"],
        type: json["type"],
        createdAt: json["createdAt"],
        id: json["id"],
        travelAgencyId: json["travelAgencyId"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "from": from,
        "to": to,
        "status": status,
        "numberOfUses": numberOfUses,
        "numberOfUsed": numberOfUsed,
        "value": value,
        "type": type,
        "createdAt": createdAt,
        "id": id,
        "travelAgencyId": travelAgencyId,
      };
}
