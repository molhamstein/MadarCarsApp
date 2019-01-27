import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/TripsSublocation.dart';
import 'package:madar_booking/models/location.dart';

class Trip {
  bool fromAirport;
  bool toAirport;
  bool inCity;
  Location location;
  DateTime startDate;
  DateTime endDate;
  Car car;
  List<TripSublocation> tripSubLocations;

  Trip({
    this.fromAirport,
    this.toAirport,
    this.inCity,
    this.location,
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
    tripSubLocations = [];
  }


  addSubLocation(String id, int duration, int cost) {
    int allSubLocationDuration = 0;
    tripSubLocations.forEach((subLocation) => allSubLocationDuration += subLocation.duration);
    if(allSubLocationDuration <= tripDuration()) {
      int index;
      if ((index =
          tripSubLocations.indexWhere((location) => location.id ==
              id)) == -1) {

        tripSubLocations.add(
            TripSublocation(id: id, duration: duration, cost: cost));
      } else {
        tripSubLocations[index].id = id;
        tripSubLocations[index].duration = duration;
        tripSubLocations[index].cost = cost;
      }
    }
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

  int estimationPrice({bool withSubLocationPrice = false}) {
    int cost = 0;
    if (inCity) {
      withSubLocationPrice ? cost += (tripDuration() - subLocationDuration()) * car.pricePerDay : cost += tripDuration() * car.pricePerDay;
    }
    if (toAirport && !fromAirport) {
      cost += car.priceOneWay;
    }
    if (fromAirport && !toAirport) {
      cost += car.priceOneWay;
    }
    if (fromAirport && toAirport) {
      cost += car.priceTowWay;
    }


    tripSubLocations.forEach((location) {
      cost += (location.duration * (location.cost == null ? 0 : location.cost));
    });
    return cost;
  }

  int tripDuration() {
    return ((endDate.difference(startDate).inHours / 24).ceil());
  }

  int subLocationDuration() {
    int allSubLocationDuration = 0;
    tripSubLocations.forEach((subLocation) { allSubLocationDuration += subLocation.duration; });
    return allSubLocationDuration;
  }

  bool isMaxDuration() {

    int allSubLocationDuration = 0;
    tripSubLocations.forEach((subLocation) => allSubLocationDuration += subLocation.duration);
    return allSubLocationDuration == tripDuration();

  }

}
