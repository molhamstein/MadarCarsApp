// To parse this JSON data, do
//
//     final myTrip = myTripFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:madar_booking/models/CouponModel.dart';
import 'package:madar_booking/models/TravelAgency.dart';

import 'TripsSublocation.dart';
import 'Car.dart';
import 'user.dart';
import 'location.dart';
import 'Driver.dart';
import 'package:date_format/date_format.dart';

String myTripToJson(List<MyTrip> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

List<MyTrip> myTripFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<MyTrip>.from(jsonData.map((x) => MyTrip.fromJson(x)));
}

class MyTrip {
  String status;
  String note;
  String type;
  int cost;
  int costBeforCoupon;
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
  bool hasInnerBill;
  String createdAt;
  String id;
  String ownerId;
  String carId;
  String locationId;
  String driverId;
  dynamic couponId;
  User owner;
  Car car;
  Location location;
  List<dynamic> tripSublocations;
  Driver driver;
  Coupon coupon;
  TravelAgency travelAgency;
  String travelAgencyId;

  MyTrip({
    this.status,
    this.note,
    this.type,
    this.cost,
    this.costBeforCoupon,
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
    this.hasInnerBill,
    this.createdAt,
    this.id,
    this.ownerId,
    this.carId,
    this.locationId,
    this.driverId,
    this.travelAgencyId,
    this.couponId,
    this.owner,
    this.car,
    this.location,
    this.tripSublocations,
    this.driver,
    this.coupon,
    this.travelAgency,
  });

  factory MyTrip.fromJson(Map<String, dynamic> json) => new MyTrip(
        status: json["status"],
        note: json["note"],
        type: json["type"],
        cost: json["cost"],
        costBeforCoupon: json["costBeforCoupon"],
        pricePerDay: json["pricePerDay"],
        priceOneWay: json["priceOneWay"],
        priceTowWay: json["priceTowWay"],
        daysInCity: json["daysInCity"],
        fromAirportDate: json["fromAirportDate"],
        fromAirport: json["fromAirport"],
        toAirportDate: json["toAirportDate"],
        toAirport: json["toAirport"],
        startInCityDate: json["startInCityDate"],
        endInCityDate: json["endInCityDate"],
        inCity: json["inCity"],
        hasOuterBill: json["hasOuterBill"],
        hasInnerBill: json["hasInnerBill"],
        createdAt: json["createdAt"],
        id: json["id"],
        ownerId: json["ownerId"],
        carId: json["carId"],
        locationId: json["locationId"],
        driverId: json["driverId"],
        travelAgencyId: json["travelAgencyId"],
        couponId: json["couponId"],
        owner: User.fromJson(json["owner"]),
        car: Car.fromJson(json["car"]),
        location: Location.fromJson(json["location"]),
        tripSublocations:
            new List<dynamic>.from(json["tripSublocations"].map((x) => x)),
        driver: Driver.fromJson(json["driver"]),
        coupon: Coupon.fromJson(json["coupon"]),
        travelAgency: TravelAgency.fromJson(json["travelAgency"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "note": note,
        "type": type,
        "cost": cost,
        "costBeforCoupon": costBeforCoupon,
        "pricePerDay": pricePerDay,
        "priceOneWay": priceOneWay,
        "priceTowWay": priceTowWay,
        "daysInCity": daysInCity,
        "fromAirportDate": fromAirportDate,
        "fromAirport": fromAirport,
        "toAirportDate": toAirportDate,
        "toAirport": toAirport,
        "startInCityDate": startInCityDate,
        "endInCityDate": endInCityDate,
        "inCity": inCity,
        "hasOuterBill": hasOuterBill,
        "hasInnerBill": hasInnerBill,
        "createdAt": createdAt,
        "id": id,
        "ownerId": ownerId,
        "carId": carId,
        "locationId": locationId,
        "driverId": driverId,
        "travelAgencyId": travelAgencyId,
        "couponId": couponId,
        "owner": owner.toJson(),
        "car": car.toJson(),
        "location": location.toJson(),
        "tripSublocations":
            new List<dynamic>.from(tripSublocations.map((x) => x)),
        "driver": driver.toJson(),
        "coupon": coupon.toJson(),
        "travelAgency": travelAgency.toJson(),
      };

  int totlaDuration() {
    int res = 0;
    tripSublocations.forEach((f) {
      res += f.duration == 0 ? 1 : f.duration;
    });
    res += daysInCity;
    return res;
  }

  String endDate() {
    if (toAirport) {
      return toAirportDate;
    }
    return endInCityDate;
  }

  String startDateFromated() {
    return formatDate(DateTime.parse(startDate()), [d, '/', m, '/', yyyy]);
  }

  bool isShowEndDate() {
    if (fromAirport == false && inCity == false) {
      return false;
    }
    return true;
  }

  bool isActive() {
    return status != "finished";
  }

  String startDate() {
    if (fromAirport) {
      return fromAirportDate;
    }
    if (inCity) {
      return startInCityDate;
    }
    return toAirportDate;
  }

  String endDateFormated() {
    return formatDate(DateTime.parse(endDate()), [d, '/', m, '/', yyyy]);
  }
}
