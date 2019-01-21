import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/Invoice.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/models/user.dart';

class Network {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

//  static final String _baseUrl = 'http://104.217.253.15:3006/api/';
  static final String _baseUrl = 'http://104.248.192.42:3000/api/';
  final String _loginUrl = _baseUrl + 'users/login?include=user';
  final String _signUpUrl = _baseUrl + 'users';
  final String _facebookLoginUrl = _baseUrl + 'users/facebookLogin';
  final String _locations = _baseUrl +
      'locations?filter[include]=subLocations&filter[where][status]=active';
  final String _avaiableCars = _baseUrl + 'cars/getAvailable';
  final String _carSubLocations = _baseUrl + 'carSublocations?filter=';
  final String _trip = _baseUrl + 'trips';

//home page links
  final String _carsUrL = _baseUrl + 'cars';
  final String _predifindTripsUrl = _baseUrl + 'predefinedTrips';
  final String _myTripsUrl = _baseUrl + 'trips/getMyTrip';
  final String _invoiceUrl = _baseUrl + 'outerBills/getouterBill/';

  Future<UserResponse> login(String phoneNumber, String password) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'password': password,
    });
    final response = await http.post(_loginUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<User> signUp(String phoneNumber, String userName, String password,
      String isoCode) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'username': userName,
      'password': password,
      'ISOCode': isoCode.toUpperCase()
    });
    final response = await http.post(_signUpUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode ==
        ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED) {
      throw ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED;
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<dynamic> getFacebookProfile(String token) async {
    final response = await http.get(
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=" +
          token,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }

  Future<UserResponse> facebookSignUp(String facebookId,
      String facebookToken) async {
    final body = json.encode({
      'socialId': facebookId,
      'token': facebookToken,
    });
    final response =
    await http.post(_facebookLoginUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      print('seeex' + json.decode(response.body).toString());
      return UserResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == ErrorCodes.NOT_COMPLETED_SN_LOGIN) {
      throw ErrorCodes.NOT_COMPLETED_SN_LOGIN;
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<User> step2FacebookSignUp(String phoneNumber, String isoCode,
      String facebookId, String facebookToken, String facebookUsername) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'name': facebookUsername,
      'socialId': facebookId,
      'token': facebookToken,
      'ISOCode': isoCode.toUpperCase(),
    });
    final response =
    await http.post(_facebookLoginUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<LocationsResponse> fetchLocations(String token) async {
    headers['Authorization'] = token;
    final response = await http.get(_locations, headers: headers);
    if (response.statusCode == 200) {
      return LocationsResponse.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<List<Car>> fetchAvailableCars(String token, Trip trip) async {
    headers['Authorization'] = token;

    String dates = '';
    if (trip.keys.keys
        .toList()
        .length == 2)
      dates =
      '{"${trip.keys.keys.toList()[0]}":"${trip.startDate.toString()}","${trip
          .keys.keys.toList()[1]}":"${trip.endDate.toString()}"}';
    else
      dates =
      '{"${trip.keys.keys.toList()[0]}":"${trip.startDate.toString()}"}';

    final url = _avaiableCars +
        '?flags={"fromAirport":${trip.fromAirport},"toAirport":${trip
            .toAirport},"inCity":${trip
            .inCity}}&dates=${dates}&locationId=${trip.location.id}';

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return (json.decode(response.body) as List)
          .map((jsonCar) => Car.fromJson(jsonCar))
          .toList();
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<List<SubLocationResponse>> fetchSubLocations(String token,
      Trip trip) async {
    headers['Authorization'] = token;

    var filter = {
      "where": {
        "and": [
          { "carId": trip.car.id},
          { "subLocationId": { "inq": trip.location.subLocationsIds}}
        ]
      }
    };

    final url = _carSubLocations + json.encode(filter);
    print(url);
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return (json.decode(response.body) as List)
          .map((jsonSubLocation) =>
          SubLocationResponse.fromJson(jsonSubLocation))
          .toList();
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }


  Future postTrip(Trip trip, String token, String userId) async {
    headers['Authorization'] = token;
//    headers.remove('Content-Type');
    final Map<String, dynamic> body = {
      "locationId": trip.location.id,
      "fromAirport": trip.fromAirport,
      "toAirport": trip.toAirport,
      "inCity": trip.inCity,
      "fromAirportDate": trip.startDate.toString(),
      "toAirportDate": trip.endDate.toString(),
      "startInCityDate": trip.startDate.toString(),
      "endInCityDate": trip.endDate.toString(),
      "driverId": trip.car.driverId,
      "pricePerDay": trip.car.pricePerDay,
      "priceOneWay": trip.car.priceOneWay,
      "priceTowWay": trip.car.priceTowWay,
      "carId": trip.car.id,
//      "tripSublocations": trip.tripSubLocations.map((location) {
//        return {
//          "sublocationId": location.subLocationId,
//          "duration": location.duration,
//        };
//      }).toList(),
      "cost": trip.estimationPrice(),
      "daysInCity": trip.tripDuration(),
      "type": "city",
      "hasOuterBill": "false",
      "status": "pending",
      "ownerId": userId,
    };

    print(json.encode(body));

    final response = await http.post(
        _trip, headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
    }
    else {
      throw json.decode(response.body);
    }
  }

  // get avalible cars in home page
  Future<List<Car>> getAvailableCars(String token) async {
    headers['Authorization'] = token;
    final response = await http.get(
      this._carsUrL,
      headers: headers,
    );
    if (response.statusCode == 200) {
      //  print(json.decode(response.body));
      return carFromJson(response.body);
    } else {
      // print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }

  // get predefined Trips
  Future<List<TripModel>> getPredifinedTrips(String token) async {
    headers['Authorization'] = token;
    final response = await http.get(
      _predifindTripsUrl,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return tripFromJson(response.body);
    } else {
      print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }

  Future<List<MyTrip>> getMyTrips(token) async {
    headers['Authorization'] = token;
    final response = await http.get(
      _myTripsUrl,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return myTripFromJson(response.body);
    } else {
      print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }

  Future<Invoice> getInvoice(String token, String tripId) async {
    headers['Authorization'] = token;
    final response = await http.get(
      _invoiceUrl + tripId,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return invoiceFromJson(response.body);
    } else {
      print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }
}

mixin ErrorCodes {
  static const int NOT_COMPLETED_SN_LOGIN = 450;
  static const int PHONENUMBER_OR_USERNAME_IS_USED = 451;
}
