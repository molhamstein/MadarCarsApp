import 'package:country_code_picker/country_code.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/validator.dart';
import 'package:rxdart/rxdart.dart';

class FacebookBloc extends BaseBloc with Validators, Network{
  final _isoCodeController = BehaviorSubject<CountryCode>();
  final _phoneController = BehaviorSubject<String>();
  final _submitController = BehaviorSubject<User>();
  final String socialId;
  final String socialToken;
  final String userName;

  FacebookBloc(this.socialId, this.socialToken, this.userName);


  Stream<User> get userStream => _submitController.stream;

  Function(String) get changePhone => _phoneController.sink.add;
  Function(CountryCode) get changeIsoCode => _isoCodeController.sink.add;

  Stream<String> get phoneStream => _phoneController.stream.transform(validatePhone);
  Stream<CountryCode> get isoCodeStream => _isoCodeController.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(phoneStream, isoCodeStream, (a, b) => true);

  submit() {
    final validPhoneNumber = _phoneController.value;
    final validIsoCode = _isoCodeController.value.code;
    step2FacebookSignUp(validPhoneNumber, validIsoCode, socialId, socialToken, userName).then((user) {
      print(user.userName);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  dispose() {
    _isoCodeController.close();
    _phoneController.close();
    _submitController.close();
  }

}