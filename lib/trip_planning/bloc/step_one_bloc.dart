import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class StepOneBloc extends BaseBloc with Network{

  final _locationsController = BehaviorSubject<List<Location>>();
  final _selectedCityIndex = BehaviorSubject<int>();
  final _selectedCityController = BehaviorSubject<Location>();


  Stream<List<Location>> get locationsStream => _locationsController.stream;
  Stream<int> get indexStream => _selectedCityIndex.stream;
  Stream<Location> get selectedCitStream => _selectedCityController.stream;
  get pushLocations => _fetchLocations();
  selectLocation(Location location, int index) {
    _selectedCityIndex.sink.add(index);
    _selectedCityController.sink.add(location);
  }

  _fetchLocations() {

    fetchLocations().then((locationsResponse) {

      print(locationsResponse.locations.first.name);
      _locationsController.sink.add(locationsResponse.locations);

    }).catchError((e) {
      print(e);
    });

  }

  @override
  void dispose() {
    _locationsController.close();
    _selectedCityIndex.close();
    _selectedCityController.close();
  }

}