import 'package:country_code_picker/country_code.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/validator.dart';
import 'package:rxdart/rxdart.dart';

class FacebookBloc extends BaseBloc with Validators, Network {
  final _isoCodeController = BehaviorSubject<CountryCode>();
  final _phoneController = BehaviorSubject<String>();
  final _submitController = BehaviorSubject<UserResponse>();
  final SocialUser user;

  FacebookBloc(this.user);

  Stream<UserResponse> get userStream => _submitController.stream;

  Function(String) get changePhone => _phoneController.sink.add;

  Function(CountryCode) get changeIsoCode => _isoCodeController.sink.add;

  Stream<String> get phoneStream =>
      _phoneController.stream.transform(validatePhone);

  Stream<CountryCode> get isoCodeStream => _isoCodeController.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(phoneStream, isoCodeStream, (a, b) => true);

  submit() {
    final validPhoneNumber = _phoneController.value;
    final validIsoCode = _isoCodeController.value.code;
    if (user.type == UserSocialLoginType.facebook) {
      step2FacebookSignUp(
              validPhoneNumber, validIsoCode, user.id, user.token, user.name)
          .then((user) {
        _submitController.sink.add(user);
      }).catchError((e) {
        print(e);
      });
    } else {
      //GOOGLE
      step2GoogleSignUp(
              validPhoneNumber, validIsoCode, user.id, user.token, user.name)
          .then((user) {
        _submitController.sink.add(user);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  dispose() {
    _isoCodeController.close();
    _phoneController.close();
    _submitController.close();
  }
}
