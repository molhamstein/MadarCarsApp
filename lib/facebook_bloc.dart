import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/validator.dart';
import 'package:rxdart/rxdart.dart';

class FacebookBloc extends BaseBloc with Validators{
  final _isoCodeController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _submitController = BehaviorSubject<User>();


  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeIsoCode => _isoCodeController.sink.add;

  Stream<String> get phoneStream => _phoneController.stream.transform(validatePhone);
  Stream<String> get isoCodeStream => _isoCodeController.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(phoneStream, isoCodeStream, (a, b) => true);

  submit() {

  }

  @override
  dispose() {
    _isoCodeController.close();
    _phoneController.close();
    _submitController.close();
  }

}