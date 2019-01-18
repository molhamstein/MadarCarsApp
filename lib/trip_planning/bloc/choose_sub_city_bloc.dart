import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';

class ChooseSubCityBloc extends BaseBloc with Network{

  final Trip _trip;
  final String token;

  ChooseSubCityBloc(this._trip, this.token);


  _fetchSubLoctaion() {

    fetchSubLocations(token, _trip).then(onValue)

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}