import 'package:rxdart/rxdart.dart';

class ReviewBloc {

  final _indexController = BehaviorSubject<double>();


  Stream<double> get indexStream => _indexController.stream;

  pushIndex(double value) => _indexController.sink.add(value);

  dispose() {
    _indexController.close();
  }

}