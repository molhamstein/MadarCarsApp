import 'Country.dart';

class User {
  static const ID = 'id';
  static const USER_NAME = 'name';
  static const PHONE_NUMBER = 'phoneNumber';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  String phoneNumber;
  String status;
  bool registrationCompleted;
  String createdAt;
  String typeLogIn;
  String userName;
  String id;
  String isoCode;
  Country country;

  User({
    this.phoneNumber,
    this.status,
    this.registrationCompleted,
    this.createdAt,
    this.typeLogIn,
    this.userName,
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
        userName: json["username"] == null ? null : json["username"],
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
        "username": userName == null ? null : userName,
        "id": id == null ? null : id,
        "ISOCode": isoCode == null ? null : isoCode,
        "country": country == null ? null : country.toJson(),
      };
}
