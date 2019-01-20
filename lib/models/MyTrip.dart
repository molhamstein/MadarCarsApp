// To parse this JSON data, do
//
//     final myTrip = myTripFromJson(jsonString);

import 'dart:convert';
import 'TripsSublocation.dart';
import 'Car.dart';
import 'user.dart';
import 'location.dart';
import 'Driver.dart';

List<MyTrip> myTripFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<MyTrip>.from(jsonData.map((x) => MyTrip.fromJson(x)));
}

String myTripToJson(List<MyTrip> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class MyTrip {
  String status;
  String type;
  int cost;
  int pricePerDay;
  int priceOneWay;
  int priceTowWay;
  int daysInCity;
  String fromAirportDate;
  bool fromAirport;
  String toAirportDate;
  bool toAirport;
  String startInCityDate;
  String endInCityDate;
  bool inCity;
  bool hasOuterBill;
  String createdAt;
  String id;
  String ownerId;
  String carId;
  String locationId;
  String driverId;
  User owner;
  Car car;
  Location location;
  List<TripSublocation> tripSublocations;
  Driver driver;

  MyTrip({
    this.status,
    this.type,
    this.cost,
    this.pricePerDay,
    this.priceOneWay,
    this.priceTowWay,
    this.daysInCity,
    this.fromAirportDate,
    this.fromAirport,
    this.toAirportDate,
    this.toAirport,
    this.startInCityDate,
    this.endInCityDate,
    this.inCity,
    this.hasOuterBill,
    this.createdAt,
    this.id,
    this.ownerId,
    this.carId,
    this.locationId,
    this.driverId,
    this.owner,
    this.car,
    this.location,
    this.tripSublocations,
    this.driver,
  });

  factory MyTrip.fromJson(Map<String, dynamic> json) => new MyTrip(
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        cost: json["cost"] == null ? null : json["cost"],
        pricePerDay: json["pricePerDay"] == null ? null : json["pricePerDay"],
        priceOneWay: json["priceOneWay"] == null ? null : json["priceOneWay"],
        priceTowWay: json["priceTowWay"] == null ? null : json["priceTowWay"],
        daysInCity: json["daysInCity"] == null ? null : json["daysInCity"],
        fromAirportDate:
            json["fromAirportDate"] == null ? null : json["fromAirportDate"],
        fromAirport: json["fromAirport"] == null ? null : json["fromAirport"],
        toAirportDate:
            json["toAirportDate"] == null ? null : json["toAirportDate"],
        toAirport: json["toAirport"] == null ? null : json["toAirport"],
        startInCityDate:
            json["startInCityDate"] == null ? null : json["startInCityDate"],
        endInCityDate:
            json["endInCityDate"] == null ? null : json["endInCityDate"],
        inCity: json["inCity"] == null ? null : json["inCity"],
        hasOuterBill:
            json["hasOuterBill"] == null ? null : json["hasOuterBill"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["ownerId"] == null ? null : json["ownerId"],
        carId: json["carId"] == null ? null : json["carId"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        driverId: json["driverId"] == null ? null : json["driverId"],
        owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        tripSublocations: json["tripSublocations"] == null
            ? null
            : new List<TripSublocation>.from(json["tripSublocations"]
                .map((x) => TripSublocation.fromJson(x))),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "cost": cost == null ? null : cost,
        "pricePerDay": pricePerDay == null ? null : pricePerDay,
        "priceOneWay": priceOneWay == null ? null : priceOneWay,
        "priceTowWay": priceTowWay == null ? null : priceTowWay,
        "daysInCity": daysInCity == null ? null : daysInCity,
        "fromAirportDate": fromAirportDate == null ? null : fromAirportDate,
        "fromAirport": fromAirport == null ? null : fromAirport,
        "toAirportDate": toAirportDate == null ? null : toAirportDate,
        "toAirport": toAirport == null ? null : toAirport,
        "startInCityDate": startInCityDate == null ? null : startInCityDate,
        "endInCityDate": endInCityDate == null ? null : endInCityDate,
        "inCity": inCity == null ? null : inCity,
        "hasOuterBill": hasOuterBill == null ? null : hasOuterBill,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "ownerId": ownerId == null ? null : ownerId,
        "carId": carId == null ? null : carId,
        "locationId": locationId == null ? null : locationId,
        "driverId": driverId == null ? null : driverId,
        "owner": owner == null ? null : owner.toJson(),
        "car": car == null ? null : car.toJson(),
        "location": location == null ? null : location.toJson(),
        "tripSublocations": tripSublocations == null
            ? null
            : new List<dynamic>.from(tripSublocations.map((x) => x.toJson())),
        "driver": driver == null ? null : driver.toJson(),
      };
}
