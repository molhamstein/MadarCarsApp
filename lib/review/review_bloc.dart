import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBloc with Network {

  final String carId;
  final String tripId;
  final String token;
  ReviewBloc(this.carId, this.tripId, this.token);

  final _indexController = BehaviorSubject<double>();
  final _submitController = BehaviorSubject<bool>();

  Stream<double> get indexStream => _indexController.stream;
  Stream<bool> get submitStream => _submitController.stream;

  pushIndex(double value) => _indexController.sink.add(value);


  submit() {
    postRate(token, carId, tripId, _indexController.value.toInt() + 1).then((_) {
      _submitController.sink.add(true);
    }).catchError((e) {
      _submitController.sink.add(false);
    });
  }

  dispose() {
    _indexController.close();
    _submitController.close();
  }

}