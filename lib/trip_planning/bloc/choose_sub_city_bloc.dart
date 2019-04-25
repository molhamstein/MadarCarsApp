import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class ChooseSubCityBloc extends BaseBloc with Network {
  final Trip _trip;
  final String token;

  ChooseSubCityBloc(this._trip, this.token);

  final _subLocationsController = BehaviorSubject<List<SubLocationResponse>>();

  get pushSubLocations => _fetchSubLocations();

  get subLocationsStream => _subLocationsController.stream;

  _fetchSubLocations() {
    fetchSubLocations(token, _trip).then((subLocations) {
      _subLocationsController.sink.add(subLocations);
    }).catchError((e) {});
  }

  @override
  void dispose() {
    _subLocationsController.close();
  }
}
