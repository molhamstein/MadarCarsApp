import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/location.dart';

class Trip {
  bool fromAirport;
  bool toAirport;
  bool inCity;
  Location location;
  DateTime startDate;
  DateTime endDate;
  Car car;
  List<TripSubLocation> _tripSubLocations;

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
    _tripSubLocations = [];
  }


  addSubLocation(String id, int duration, int cost) {
    int allSubLocationDuration = 0;
    _tripSubLocations.forEach((subLocation) => allSubLocationDuration += subLocation.duration);
    if(allSubLocationDuration <= tripDuration()) {
      int index;
      if ((index =
          _tripSubLocations.indexWhere((location) => location.subLocationId ==
              id)) == -1) {

        _tripSubLocations.add(
            TripSubLocation(subLocationId: id, duration: duration, cost: cost));
      } else {
        _tripSubLocations[index].subLocationId = id;
        _tripSubLocations[index].duration = duration;
        _tripSubLocations[index].cost = cost;
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

  int estimationPrice() {
    int cost = 0;
    if (inCity)
      cost +=
          (tripDuration() - subLocationDuration()) * car.pricePerDay;
    if (toAirport && !fromAirport) {
      cost += car.priceOneWay;
    }
    if (fromAirport && !toAirport) {
      cost += car.priceOneWay;
    }
    if (fromAirport && toAirport) {
      cost += car.priceTowWay;
    }
    
    _tripSubLocations.forEach((location) => cost += (location.duration * location.cost));
    
    return cost;
  }

  int tripDuration() {
    return ((endDate.difference(startDate).inHours / 24).ceil());
  }

  int subLocationDuration() {
    int allSubLocationDuration = 0;
    _tripSubLocations.forEach((subLocation) => allSubLocationDuration += subLocation.duration);
    return allSubLocationDuration;
  }

  bool isMaxDuration() {

    int allSubLocationDuration = 0;
    _tripSubLocations.forEach((subLocation) => allSubLocationDuration += subLocation.duration);
    return allSubLocationDuration == tripDuration();

  }

}


class TripSubLocation {

  String subLocationId;
  int duration;
  int cost;

  TripSubLocation({this.subLocationId, this.duration, this.cost});


}