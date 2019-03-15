import 'package:madar_booking/DataStore.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Airport.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseAirportBloc extends BaseBloc with Network {
  final Trip trip;
  final String token;

  SharedPreferences _prefs;
  AppBloc bloc;

  DataStore dataStore;

  ChooseAirportBloc(this.trip, this.token);

  final _carsController = BehaviorSubject<List<Car>>();
  final _selectedAirportIndexController = BehaviorSubject<int>();
  final _selectedAirportController = BehaviorSubject<Airport>();

  Stream<List<Car>> get carsStream => _carsController.stream;

  Stream<int> get indexStream => _selectedAirportIndexController.stream;

  Stream<Airport> get selectedAirportStream =>
      _selectedAirportController.stream;

//   selectCar(Car car, int index) {
//     trip.car = car;
//     print(trip.car.id);
//     print("car name is : " + trip.car.name);

// //    dataStore.saveCarName(trip.car.name);

//     _selectedCarController.sink.add(car);
//     _selectedAirportIndexController.sink.add(index);
//   }

  selectAirport(Airport airport, int index) {
    // _selectedCarController.sink.add(car);
    trip.airport = airport;
    _selectedAirportController.sink.add(airport);
    _selectedAirportIndexController.sink.add(index);
  }

  fetchGetAvailableCars(
      {List<String> langIds,
      Gender gender,
      Type type,
      int numberOfSeats,
      String productionDate}) {
    fetchAvailableCars(
            token,
            trip,
            langIds,
            numberOfSeats,
            gender.toString().split('.').last,
            type.toString().split('.').last,
            productionDate)
        .then((carsList) {
      _carsController.sink.add(carsList);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _carsController.close();
    _selectedAirportIndexController.close();
    _selectedAirportController.close();
  }
}
