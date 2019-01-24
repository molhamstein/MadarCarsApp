// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';
import 'package:madar_booking/models/Brand.dart';
import 'package:madar_booking/models/Driver.dart';
import 'package:madar_booking/models/Image.dart';
import 'package:madar_booking/models/Location.dart';

List<Car> carFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Car>.from(jsonData.map((x) => Car.fromJson(x)));
}

String carToJson(List<Car> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Car {
  String name;
  int rate;
  int numRateing;
  int numOfSeat;
  bool isVip;
  int pricePerDay;
  int priceOneWay;
  int priceTowWay;
  int productionDate;
  String engineType;
  String type;
  bool isAirportCar;
  bool isCityCar;
  String status;
  String createdAt;
  String id;
  String brandId;
  String mediaId;
  String locationId;
  String driverId;
  String color1;
  String color2;
  Brand brand;
  Location location;
  Driver driver;
  List<dynamic> carMedia;
  List<CarSublocation> carSublocations;
  Media media;

  Car({
    this.name,
    this.rate,
    this.numRateing,
    this.numOfSeat,
    this.isVip,
    this.pricePerDay,
    this.priceOneWay,
    this.priceTowWay,
    this.productionDate,
    this.engineType,
    this.type,
    this.isAirportCar,
    this.isCityCar,
    this.status,
    this.createdAt,
    this.id,
    this.brandId,
    this.mediaId,
    this.locationId,
    this.driverId,
    this.color1,
    this.color2,
    this.brand,
    this.location,
    this.driver,
    this.carMedia,
    this.carSublocations,
    this.media,
  });

  factory Car.fromJson(Map<String, dynamic> json) => new Car(
        name: json["name"] == null ? null : json["name"],
        rate: json["rate"] == null ? null : json["rate"],
        numRateing: json["numRateing"] == null ? null : json["numRateing"],
        numOfSeat: json["numOfSeat"] == null ? null : json["numOfSeat"],
        isVip: json["isVip"] == null ? null : json["isVip"],
        pricePerDay: json["pricePerDay"] == null ? null : json["pricePerDay"],
        priceOneWay: json["priceOneWay"] == null ? null : json["priceOneWay"],
        priceTowWay: json["priceTowWay"] == null ? null : json["priceTowWay"],
        productionDate:
            json["productionDate"] == null ? null : json["productionDate"],
        engineType: json["engineType"] == null ? null : json["engineType"],
        type: json["type"] == null ? null : json["type"],
        isAirportCar:
            json["isAirportCar"] == null ? null : json["isAirportCar"],
        isCityCar: json["isCityCar"] == null ? null : json["isCityCar"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        brandId: json["brandId"] == null ? null : json["brandId"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        driverId: json["driverId"] == null ? null : json["driverId"],
        color1: json["color1"] == null ? null : json["color1"],
        color2: json["color2"] == null ? null : json["color2"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        carMedia: json["carMedia"] == null
            ? null
            : new List<dynamic>.from(json["carMedia"].map((x) => x)),
        carSublocations: json["carSublocations"] == null
            ? null
            : new List<CarSublocation>.from(
                json["carSublocations"].map((x) => CarSublocation.fromJson(x))),
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "rate": rate == null ? null : rate,
        "numRateing": numRateing == null ? null : numRateing,
        "numOfSeat": numOfSeat == null ? null : numOfSeat,
        "isVip": isVip == null ? null : isVip,
        "pricePerDay": pricePerDay == null ? null : pricePerDay,
        "priceOneWay": priceOneWay == null ? null : priceOneWay,
        "priceTowWay": priceTowWay == null ? null : priceTowWay,
        "productionDate": productionDate == null ? null : productionDate,
        "engineType": engineType == null ? null : engineType,
        "type": type == null ? null : type,
        "isAirportCar": isAirportCar == null ? null : isAirportCar,
        "isCityCar": isCityCar == null ? null : isCityCar,
        "status": status == null ? null : status,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "brandId": brandId == null ? null : brandId,
        "mediaId": mediaId == null ? null : mediaId,
        "locationId": locationId == null ? null : locationId,
        "driverId": driverId == null ? null : driverId,
        "color1": color1 == null ? null : color1,
        "color2": color2 == null ? null : color2,
        "brand": brand == null ? null : brand.toJson(),
        "location": location == null ? null : location.toJson(),
        "driver": driver == null ? null : driver.toJson(),
        "carMedia": carMedia == null
            ? null
            : new List<dynamic>.from(carMedia.map((x) => x)),
        "carSublocations": carSublocations == null
            ? null
            : new List<dynamic>.from(carSublocations.map((x) => x.toJson())),
        "media": media == null ? null : media.toJson(),
      };
}

class CarSublocation {
  int cost;
  String id;
  String carId;
  String subLocationId;
  SubLocation subLocation;

  CarSublocation({
    this.cost,
    this.id,
    this.carId,
    this.subLocationId,
    this.subLocation,
  });

  factory CarSublocation.fromJson(Map<String, dynamic> json) =>
      new CarSublocation(
        cost: json["cost"] == null ? null : json["cost"],
        id: json["id"] == null ? null : json["id"],
        carId: json["carId"] == null ? null : json["carId"],
        subLocationId:
            json["subLocationId"] == null ? null : json["subLocationId"],
        subLocation: json["subLocation"] == null
            ? null
            : SubLocation.fromJson(json["subLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "cost": cost == null ? null : cost,
        "id": id == null ? null : id,
        "carId": carId == null ? null : carId,
        "subLocationId": subLocationId == null ? null : subLocationId,
        "subLocation": subLocation == null ? null : subLocation.toJson(),
      };
}

class SubLocation {
  String nameEn;
  String nameAr;
  String nameTr;
  String status;
  String color1;
  String color2;
  String createdAt;
  String id;
  String locationId;
  String mediaId;
  Media media;
  Location location;

  SubLocation({
    this.nameEn,
    this.nameAr,
    this.nameTr,
    this.status,
    this.color1,
    this.color2,
    this.createdAt,
    this.id,
    this.locationId,
    this.mediaId,
    this.media,
    this.location,
  });

  factory SubLocation.fromJson(Map<String, dynamic> json) => new SubLocation(
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        nameAr: json["nameAr"] == null ? null : json["nameAr"],
        nameTr: json["nameTr"] == null ? null : json["nameTr"],
        status: json["status"] == null ? null : json["status"],
        color1: json["color1"] == null ? null : json["color1"],
        color2: json["color2"] == null ? null : json["color2"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        mediaId: json["mediaId"] == null ? null : json["mediaId"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "nameEn": nameEn == null ? null : nameEn,
        "nameAr": nameAr == null ? null : nameAr,
        "nameTr": nameTr == null ? null : nameTr,
        "status": status == null ? null : status,
        "color1": color1 == null ? null : color1,
        "color2": color2 == null ? null : color2,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "locationId": locationId == null ? null : locationId,
        "mediaId": mediaId == null ? null : mediaId,
        "media": media == null ? null : media.toJson(),
        "location": location == null ? null : location.toJson(),
      };


  String name(Locale locale) {
    if(locale.languageCode == 'en') {
      return nameEn;
    } return nameAr;
   }

}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
