import 'package:madar_booking/models/Car.dart';

class Trip {
  bool fromAirport;
  bool toAirport;
  bool inCity;
  String locationId;
  DateTime startDate;
  DateTime endDate;
  Car car;

  Trip({
    this.fromAirport,
    this.toAirport,
    this.inCity,
    this.locationId,
    this.startDate,
    this.endDate,
    this.car,
  });

  Trip.init() {
    fromAirport = false;
    toAirport = false;
    inCity = false;
    startDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    endDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 23);
  }

  Map<String, dynamic> get keys {
    Map<String, dynamic> dates = {};

    if (inCity) {
      if (fromAirport)
        dates['fromAirportDate'] = startDate;
      else
        dates['startInCityDate'] = startDate;
      if (toAirport)
        dates['toAirportDate'] = endDate;
      else
        dates['endInCityDate'] = endDate;
    }

    if (fromAirport) dates['fromAirportDate'] = startDate;
    if (toAirport) dates['toAirportDate'] = endDate;

    return dates;
  }

  int carEstimationPrice(int pricePerDay, priceOneWay, priceTwoWay) {
    int cost = 0;
    if (inCity)
      cost +=
          ((endDate.difference(startDate).inHours / 24).ceil()) * pricePerDay;
    if (toAirport && !fromAirport) {
      cost += priceOneWay;
    }
    if (fromAirport && !toAirport) {
      cost += priceOneWay;
    }
    if (fromAirport && toAirport) {
      cost += priceTwoWay;
    }

    return cost;
  }
}
