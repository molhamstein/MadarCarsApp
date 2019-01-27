// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';
import 'package:madar_booking/models/TripModel.dart';

Invoice invoiceFromJson(String str) {
  final jsonData = json.decode(str);
  return Invoice.fromJson(jsonData);
}

String invoiceToJson(Invoice data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Invoice {
  String status;
  String createdAt;
  String id;
  String tripId;
  String ownerId;
  List<Bill> bills;
  TripModel trip;

  Invoice({
    this.status,
    this.createdAt,
    this.id,
    this.tripId,
    this.ownerId,
    this.bills,
    this.trip,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => new Invoice(
        status: json["status"] == null ? null : json["status"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        tripId: json["tripId"] == null ? null : json["tripId"],
        ownerId: json["ownerId"] == null ? null : json["ownerId"],
        bills: json["bills"] == null
            ? null
            : new List<Bill>.from(json["bills"].map((x) => Bill.fromJson(x))),
        trip: json["trip"] == null ? null : TripModel.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "tripId": tripId == null ? null : tripId,
        "ownerId": ownerId == null ? null : ownerId,
        "bills": bills == null
            ? null
            : new List<dynamic>.from(bills.map((x) => x.toJson())),
        "trip": trip == null ? null : trip.toJson(),
      };
}

class Bill {
  String titleEn;
  String titleAr;
  String titleTr;
  int quantity;
  int pricePerUnit;
  int totalPrice;
  String id;
  String typeBillId;
  String outerBillId;

  Bill({
    this.titleEn,
    this.titleAr,
    this.titleTr,
    this.quantity,
    this.pricePerUnit,
    this.totalPrice,
    this.id,
    this.typeBillId,
    this.outerBillId,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => new Bill(
        titleEn: json["titleEn"] == null ? null : json["titleEn"],
        titleAr: json["titleAr"] == null ? null : json["titleAr"],
        titleTr: json["titleTr"] == null ? null : json["titleTr"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        pricePerUnit:
            json["pricePerUnit"] == null ? null : json["pricePerUnit"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        id: json["id"] == null ? null : json["id"],
        typeBillId: json["typeBillId"] == null ? null : json["typeBillId"],
        outerBillId: json["outerBillId"] == null ? null : json["outerBillId"],
      );

  Map<String, dynamic> toJson() => {
        "titleEn": titleEn == null ? null : titleEn,
        "titleAr": titleAr == null ? null : titleAr,
        "titleTr": titleTr == null ? null : titleTr,
        "quantity": quantity == null ? null : quantity,
        "pricePerUnit": pricePerUnit == null ? null : pricePerUnit,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "id": id == null ? null : id,
        "typeBillId": typeBillId == null ? null : typeBillId,
        "outerBillId": outerBillId == null ? null : outerBillId,
      };

  String title(Locale locale) {
    if (locale.languageCode == 'en') {
      return titleEn;
    }
    return titleAr;
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
