import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/location.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class ChooseCityBloc extends BaseBloc with Network {
  final String token;

  ChooseCityBloc(this.token);

  final _selectedCityController = BehaviorSubject<Location>();
  final _locationsController = BehaviorSubject<List<Location>>();
  final _selectedCityIndex = BehaviorSubject<int>();

  Stream<List<Location>> get locationsStream => _locationsController.stream;

  Stream<int> get indexStream => _selectedCityIndex.stream;
  Stream<Location> get selectedCitStream => _selectedCityController.stream;
  get pushLocations => _fetchLocations();


  selectLocation(Location location, int index) {


    _selectedCityIndex.sink.add(index);
    _selectedCityController.sink.add(location);
  }

  _fetchLocations() {
List<Location> mainSubLocation = []  ;


    fetchLocations(token).then((locationsResponse) {
//      print("subLocations after parse"+locationsResponse.locations[0].subLocations[1].nameEn);
for(int i =0 ; i < locationsResponse.locations.length ; i++ ){
print("Location is : "+locationsResponse.locations[i].nameEn);

    mainSubLocation.add(locationsResponse.locations[i]);
  for(int j = 0 ; j < locationsResponse.locations[i].subLocations.length; j++){

    print("subLocations after parse : "+locationsResponse.locations[i].subLocations[j].nameEn);
    mainSubLocation.add(locationsResponse.locations[i].subLocations[j]);

  }
}

print(mainSubLocation);


      _locationsController.sink.add(mainSubLocation);
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
