import 'dart:async';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'validator.dart';

class AuthBloc extends BaseBloc with Validators, Network {
  final _phoneLoginController = BehaviorSubject<String>();
  final _passwordLoginController = BehaviorSubject<String>();

  final _obscureLoginPasswordController =
      BehaviorSubject<bool>(seedValue: true);

  final _obscureSignUpPassword = BehaviorSubject<bool>(seedValue: true);
  final _obscureSignUpPasswordConfirmation =
      BehaviorSubject<bool>(seedValue: true);

  final _submitLoginController = BehaviorSubject<User>();

  final _loadingController = BehaviorSubject<bool>();

  get pushLockTouchEvent => _loadingController.sink.add(true);

  Function(String) get changePhoneEmail => _phoneLoginController.sink.add;

  Function(String) get changeLoginPassword => _passwordLoginController.sink.add;

  get pushObscureSignUpPassword =>
      _obscureSignUpPassword.sink.add(!_obscureSignUpPassword.value);

  Stream<bool> get obscureSignUpPasswordStream => _obscureSignUpPassword.stream;

  get pushObscureSignUpPasswordConfirmation =>
      _obscureSignUpPasswordConfirmation.sink
          .add(!_obscureSignUpPasswordConfirmation.value);

  Stream<bool> get obscureSignUpPasswordConfirmationStream =>
      _obscureSignUpPasswordConfirmation.stream;

  get pushObscureLoginPassword => _obscureLoginPasswordController.sink.add(!_obscureLoginPasswordController.value);
  Stream<bool> get obscureLoginPasswordStream => _obscureLoginPasswordController.stream;

  Stream<String> get phoneLoginStream =>
      _phoneLoginController.stream.transform(validateEmail);

  Stream<String> get passwordLoginStream =>
      _passwordLoginController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(phoneLoginStream, passwordLoginStream, (a, b) => true);

  Stream<User> get submitLoginStream => _submitLoginController.stream;

  Stream<bool> get lockTouchEventStream => _loadingController.stream;

  submit() {
    final validEmail = _phoneLoginController.value;
    final validPassword = _passwordLoginController.value;
    print("Email: ${validEmail}, Password: ${validPassword}");
    pushLockTouchEvent;
    
    login('0957465877', 'password').then((response) {
      print(response.token);
      _submitLoginController.add(response.user);
    }).catchError((e) {
      print(e);
      _submitLoginController.addError(e);
    });

  }

  dispose() {
    _phoneLoginController.close();
    _passwordLoginController.close();
    _obscureSignUpPassword.close();
    _obscureSignUpPasswordConfirmation.close();
    _obscureLoginPasswordController.close();
    _submitLoginController.close();
    _loadingController.close();
  }
}
