import 'package:madar_booking/models/Airport.dart';
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
  String note;
  String couponId;
  Airport airport;
  bool hasManyAirport;
  bool withPayment ;
  String cardHolderName;
  String cardNumber;
  String expireMonth;
  String expireYear;
  String cvc ;
  String tripId;



  List<TripSublocation> tripSubLocations;

  Trip(
      {this.fromAirport,
      this.toAirport,
      this.inCity,
      this.location,
      this.startDate,
      this.endDate,
      this.car,
      this.couponId,
      this.hasManyAirport,
      this.airport,
      this.cardHolderName,
      this.cardNumber,
      this.expireMonth,
      this.expireYear,
      this.cvc
      ,this.tripId});

  Trip.init() {
    fromAirport = false;
    toAirport = false;
    inCity = false;
    startDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    endDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 23);
    tripSubLocations = [];
    hasManyAirport = false;
    note = '';
  }

  addSubLocation(String id, int duration, int cost, String subName) {
    int allSubLocationDuration = 0;
    tripSubLocations.forEach(
        (subLocation) => allSubLocationDuration += subLocation.duration);
    if (allSubLocationDuration <= tripTotalDuration()) {
      int index;
      if ((index =
              tripSubLocations.indexWhere((location) => location.id == id)) ==
          -1) {
        tripSubLocations.add(TripSublocation(
            id: id,
            duration: duration,
            cost: cost,
            subLocation: SubLocation(nameTr: subName)));
      } else {
        tripSubLocations[index].id = id;
        tripSubLocations[index].duration = duration;
        tripSubLocations[index].cost = cost;
        tripSubLocations[index].subLocation.nameEn = subName;
      }
    }
  }

// new function for add day by day sublocations
  addSubLocations(String id, int duration, int cost, String subName, int idx) {
    // int allSubLocationDuration = 0;
    // tripSubLocations.forEach(
    //     (subLocation) => allSubLocationDuration += subLocation.duration);
    // if (allSubLocationDuration <= tripTotalDuration()) {
    //   int index;
    //   if ((index =
    //           tripSubLocations.indexWhere((location) => location.id == id)) ==
    //       -1) {
    tripSubLocations.add(TripSublocation(
        id: id,
        duration: duration,
        cost: cost,
        subLocation: SubLocation(nameTr: subName)));
    //   } else {
    //     tripSubLocations[index].id = id;
    //     tripSubLocations[index].duration = duration;
    //     tripSubLocations[index].cost = cost;
    //     tripSubLocations[index].subLocation.nameEn = subName;
    //   }
    // }
  }

  editSubLocation(int duration, int index) {
    print("theeeeeeeeeeee index is :" + index.toString());
    tripSubLocations[index].duration = duration;
  }

  int getSubLocationDurationByNewId(String id, int index) {
    print(id);
    print(index);
    var duration = 0;
//    for(int i=0 ; i <= tripSubLocations.length ; i++)
//      {
//        if(  tripSubLocations[index].id == id){
//          print("index isssssssssssssssssss :"+index.toString() + "id is :"+id);
//          duration = tripSubLocations[index].duration;
//        }
//      }
    duration = tripSubLocations[index].duration;
    print("sublocation $id duration  $duration");
    return duration;
  }

  int getSubLocationDurationById(String id) {
    print(id);
    var duration = 0;
    tripSubLocations.forEach((subLocation) {
      if (subLocation.id == id) {
        duration = subLocation.duration;
      }
    });
    print("sublocation $id duration  $duration");
    return duration;
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

  double estimationPriceWithPercentageDiscount(int percentage) {
    double num = (1 - (percentage / 100)) * estimationPrice();
    return num;
  }

  int estimationPriceWithFixedDiscount(int discount) {
    int num = estimationPrice() - discount;
    return num;
  }

  int estimationPrice({bool withSubLocationPrice = false}) {
    int cost = 0;
    var tripduration = tripDuration();
    var totladuration = tripTotalDuration();
    withSubLocationPrice = tripSubLocations.length > 0;
    print(tripduration);
    print(totladuration);
    if (inCity) {
      withSubLocationPrice
          ? cost += (tripduration) * car.pricePerDay
          : cost += totladuration * car.pricePerDay;
    }

    if (toAirport && !fromAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceOneWay;
          }
        });
      }
    } else if (fromAirport && !toAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceOneWay;
          }
        });
      }
    } else if (fromAirport && toAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceTowWay;
          }
        });
      }
    }

    tripSubLocations.forEach((location) {
      cost += (location.duration * (location.cost == null ? 0 : location.cost));
    });
    print("sublocations num ${tripSubLocations.length}");
    print("subbbbb estim cost function  $cost");
    return cost;
  }

  int tripCost() {
    int cost = 0;
    var totladuration = tripTotalDuration();
    if (inCity) {
      cost += (totladuration) * car.pricePerDay;
    }

    if (toAirport && !fromAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceOneWay;
          }
        });
      }
    } else if (fromAirport && !toAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceOneWay;
          }
        });
      }
    } else if (fromAirport && toAirport) {
      if (airport != null && car != null) {
        car.carsAirport.forEach((ap) {
          if (ap.airportId == airport.id) {
            cost += ap.priceTowWay;
          }
        });
      }
    }
    return cost;
  }

  int tripDuration() {
    return tripTotalDuration() - subLocationDuration();
  }

  int tripTotalDuration() {
    return ((endDate.difference(startDate).inHours / 24).ceil());
  }

  int subLocationDuration() {
    int allSubLocationDuration = 0;
    tripSubLocations.forEach((subLocation) {
      allSubLocationDuration += subLocation.duration;
    });
    return allSubLocationDuration;
  }

  bool isMaxDuration() {
    int allSubLocationDuration = 0;
    tripSubLocations.forEach(
        (subLocation) => allSubLocationDuration += subLocation.duration);
    var tripDur = tripTotalDuration();
    return allSubLocationDuration >= tripDur;
  }
}
