import 'package:madar_booking/DataStore.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseCarBloc extends BaseBloc with Network {
  final Trip trip;
  final String token;

  SharedPreferences _prefs;
  AppBloc bloc;

  DataStore dataStore;

  ChooseCarBloc(this.trip, this.token);



var shouldShowProgressIndecator = false ;

  final _carsController = BehaviorSubject<List<Car>>();
  final _selectedCarIndexController = BehaviorSubject<int>();
  final _selectedCarController = BehaviorSubject<Car>();

  Stream<List<Car>> get carsStream => _carsController.stream;

  Stream<int> get indexStream => _selectedCarIndexController.stream;

  Stream<Car> get selectedCarStream => _selectedCarController.stream;

  selectCar(Car car, int index) {
    trip.car = car;
    print(trip.car.id);
    print("car name is : " +trip.car.name);

//    dataStore.saveCarName(trip.car.name);

    _selectedCarController.sink.add(car);
    _selectedCarIndexController.sink.add(index);

  }

  fetchGetAvailableCars(
      {List<String> langIds,
      Gender gender,
        Type type,
        int numberOfSeats,
        String productionDate}) {
    shouldShowProgressIndecator = true ;
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
      shouldShowProgressIndecator = false;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _carsController.close();
    _selectedCarIndexController.close();
    _selectedCarController.close();
  }
}
