import 'Country.dart';

class User {
  static const ID = 'id';
  static const USER_NAME = 'username';
  static const PHONE_NUMBER = 'phoneNumber';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  String phoneNumber;
  String status;
  bool registrationCompleted;
  String createdAt;
  String typeLogIn;
  String name;
  String id;
  String isoCode;
  Country country;

  User({
    this.phoneNumber,
    this.status,
    this.registrationCompleted,
    this.createdAt,
    this.typeLogIn,
    this.name,
    this.id,
    this.isoCode,
    this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        status: json["status"] == null ? null : json["status"],
        registrationCompleted: json["registrationCompleted"] == null
            ? null
            : json["registrationCompleted"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        typeLogIn: json["typeLogIn"] == null ? null : json["typeLogIn"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        isoCode: json["ISOCode"] == null ? null : json["ISOCode"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "status": status == null ? null : status,
        "registrationCompleted":
            registrationCompleted == null ? null : registrationCompleted,
        "createdAt": createdAt == null ? null : createdAt,
        "typeLogIn": typeLogIn == null ? null : typeLogIn,
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "ISOCode": isoCode == null ? null : isoCode,
        "country": country == null ? null : country.toJson(),
      };
}
