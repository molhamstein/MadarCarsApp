// To parse this JSON data, do
//
//     final myTrip = myTripFromJson(jsonString);

import 'dart:convert';
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
  String travelAgencyId;
  String couponId;
  User owner;
  Car car;
  Location location;
  List<TripSublocation> tripSublocations;
  Driver driver;
  Coupon coupon;
  TravelAgency travelAgency;

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
        status: json["status"] == null ? null : json["status"],
        note: json["note"] == null ? null : json["note"],
        type: json["type"] == null ? null : json["type"],
        cost: json["cost"] == null ? null : json["cost"],
        costBeforCoupon:
            json["costBeforCoupon"] == null ? null : json["costBeforCoupon"],
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
        hasInnerBill:
            json["hasInnerBill"] == null ? null : json["hasInnerBill"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["ownerId"] == null ? null : json["ownerId"],
        carId: json["carId"] == null ? null : json["carId"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        driverId: json["driverId"] == null ? null : json["driverId"],
        couponId: json["couponId"],
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
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        travelAgency: json["travelAgency"] == null
            ? null
            : TravelAgency.fromJson(json["travelAgency"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "note": note == null ? null : note,
        "type": type == null ? null : type,
        "cost": cost == null ? null : cost,
        "costBeforCoupon": costBeforCoupon == null ? null : costBeforCoupon,
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
        "hasInnerBill": hasInnerBill == null ? null : hasInnerBill,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "ownerId": ownerId == null ? null : ownerId,
        "carId": carId == null ? null : carId,
        "locationId": locationId == null ? null : locationId,
        "driverId": driverId == null ? null : driverId,
        "couponId": couponId,
        "owner": owner == null ? null : owner.toJson(),
        "car": car == null ? null : car.toJson(),
        "location": location == null ? null : location.toJson(),
        "tripSublocations": tripSublocations == null
            ? null
            : new List<dynamic>.from(tripSublocations.map((x) => x.toJson())),
        "driver": driver == null ? null : driver.toJson(),
        "coupon": coupon == null ? null : coupon.toJson(),
        "travelAgency": travelAgency == null ? null : travelAgency.toJson(),
      };

  int totlaDuration() {
    // int res = 0;
    // tripSublocations.forEach((f) {
    //   res += f.duration == 0 ? 1 : f.duration;
    // });
    // res += daysInCity;

    DateTime startdate = DateTime.parse(startDate());
    DateTime enddate = DateTime.parse(endDate());
    return ((enddate.difference(startdate).inHours / 24).ceil());
    // return res;
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

  int tripDuration() {
    DateTime startdate = DateTime.parse(startDate());
    DateTime enddate = DateTime.parse(endDate());
    return ((enddate.difference(startdate).inHours / 24).ceil());
  }
}
