import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/models/CheckCouponModel.dart';
import 'package:madar_booking/models/sub_location_response.dart';
import 'package:madar_booking/models/trip.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class CouponBloc extends BaseBloc with Network{

  final String token;

  CouponBloc( this.token);

  final _couponsController = BehaviorSubject<CheckCoupon>();

  get pushCoupon => fetchCoupon();

  get subLocationsStream => _couponsController.stream;

  fetchCoupon() {

    fetchCheckCoupon().then((coupons) {

      _couponsController.sink.add(coupons);

    }).catchError((e) {

    });

  }

  @override
  void dispose() {
    _couponsController.close();
  }

}