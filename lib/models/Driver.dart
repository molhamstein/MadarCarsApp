import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/DriverLang.dart';
import 'package:madar_booking/models/media.dart';

enum Type { IMAGE }

final typeValues = new EnumValues({"image": Type.IMAGE});

class Driver {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String status;
  String gender;
  String createdAt;
  String username;
  String id;
  String mediaId;
  List<DriverLang> driverLangs;
  Media media;

  Driver({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.status,
    this.gender,
    this.createdAt,
    this.username,
    this.id,
    this.mediaId,
    this.driverLangs,
    this.media,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => new Driver(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        email: json["email"] == null ? null : json["email"],
        status: json["status"] == null ? null : json["status"],
        gender: json["gender"] == null ? null : json["gender"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        username: json["username"] == null ? null : json["username"],
        id: json["id"] == null ? null : json["id"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        driverLangs: json["driverLangs"] == null
            ? null
            : new List<DriverLang>.from(
                json["driverLangs"].map((x) => DriverLang.fromJson(x))),
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "status": status == null ? null : status,
        "gender": gender == null ? null : gender,
        "createdAt": createdAt == null ? null : createdAt,
        "username": username == null ? null : username,
        "id": id == null ? null : id,
        "mediaId": mediaId == null ? null : mediaId,
        "driverLangs": driverLangs == null
            ? null
            : new List<dynamic>.from(driverLangs.map((x) => x.toJson())),
        "media": media == null ? null : media.toJson(),
      };
}
