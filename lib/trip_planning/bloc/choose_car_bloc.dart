import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ChooseCarBloc extends BaseBloc with Network {
  final Trip trip;
  final String token;

  ChooseCarBloc(this.trip, this.token);

  final _carsController = BehaviorSubject<List<Car>>();
  final _selectedCarIndexController = BehaviorSubject<int>();
  final _selectedCarController = BehaviorSubject<Car>();

  Stream<List<Car>> get carsStream => _carsController.stream;

  Stream<int> get indexStream => _selectedCarIndexController.stream;

  Stream<Car> get selectedCarStream => _selectedCarController.stream;

  selectCar(Car car, int index) {
    _selectedCarController.sink.add(car);
    _selectedCarIndexController.sink.add(index);
  }

  get pushCars => _fetchAvailableCars();

  _fetchAvailableCars(
      {List<String> langIds, Gender gender, Type type, int numberOfSeats}) {
    fetchAvailableCars(token, trip, langIds, numberOfSeats,
            gender.toString().split('.').last, type.toString().split('.').last)
        .then((carsList) {
      _carsController.sink.add(carsList);
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
