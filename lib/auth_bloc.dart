import 'dart:async';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'validator.dart';

class AuthBloc extends BaseBloc with Validators, Network {
  final _phoneLoginController = BehaviorSubject<String>();
  final _passwordLoginController = BehaviorSubject<String>();

  final _phoneSignUpController = BehaviorSubject<String>();
  final _passwordSignUpController = BehaviorSubject<String>();
  final _nameSignUpController = BehaviorSubject<String>();
  final _isoCodeSignUpController = BehaviorSubject<String>();

  final _obscureLoginPasswordController =
      BehaviorSubject<bool>(seedValue: true);

  final _obscureSignUpPassword = BehaviorSubject<bool>(seedValue: true);
  final _obscureSignUpPasswordConfirmation =
      BehaviorSubject<bool>(seedValue: true);

  final _submitLoginController = BehaviorSubject<User>();
  final _submitSignUpController = BehaviorSubject<User>();

  final _loadingController = BehaviorSubject<bool>();

  get pushLockTouchEvent => _loadingController.sink.add(true);

  Function(String) get changeLoginPhone => _phoneLoginController.sink.add;

  Function(String) get changeLoginPassword => _passwordLoginController.sink.add;

  Function(String) get changeSignUpPhone => _phoneSignUpController.sink.add;

  Function(String) get changeSignUpUserName => _nameSignUpController.sink.add;

  Function(String) get changeSignUpPassword => _passwordSignUpController.sink.add;

  Function(String) get changeSignUpIsoCode => _isoCodeSignUpController.sink.add;

  Stream<String> get phoneSignUpStream =>
      _phoneSignUpController.stream.transform(validatePhone);
  Stream<String> get nameSignUpStream =>
      _nameSignUpController.stream.transform(validateName);
  Stream<String> get passwordSignUpStream =>
      _passwordSignUpController.stream.transform(validatePassword);
//  Stream<String> get isoCodeSignUpStream =>
//      _isoCodeSignUpController.stream.transform(validatePhone);

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
      _phoneLoginController.stream.transform(validatePhone);

  Stream<String> get passwordLoginStream =>
      _passwordLoginController.stream.transform(validatePassword);

  Stream<bool> get submitValidLogin =>
      Observable.combineLatest2(phoneLoginStream, passwordLoginStream, (a, b) => true);

  Stream<bool> get submitValidSignUp =>
      Observable.combineLatest3(phoneSignUpStream, passwordSignUpStream,nameSignUpStream, (a, b, c) => true);

  Stream<User> get submitLoginStream => _submitLoginController.stream;
  Stream<User> get submitSignUpStream => _submitLoginController.stream;

  Stream<bool> get lockTouchEventStream => _loadingController.stream;

  submitLogin() {
    final validPhoneNumber = _phoneLoginController.value;
    final validPassword = _passwordLoginController.value;
    pushLockTouchEvent;
    
    login('0957465877', 'password').then((response) { //TODO: put real values (from controller).
      print(response.token);
      _submitLoginController.sink.add(response.user);
    }).catchError((e) {
      print(e);
      _submitLoginController.sink.addError(e);
    });
  }

  submitSignUp() {
    final validUserName = _nameSignUpController.value;
    final validPhoneNumber = _phoneSignUpController.value;
    final validPassword = _passwordSignUpController.value;
    final validIsoCode = _isoCodeSignUpController.value;
    pushLockTouchEvent;

    signUp(validPhoneNumber, validUserName, validPassword, validIsoCode).then((user) {
      _submitSignUpController.sink.add(user);
      print(user.userName);
    }).catchError((e) {
      print(e);
      _submitSignUpController.sink.addError(e);
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
    _phoneSignUpController.close();
    _nameSignUpController.close();
    _passwordSignUpController.close();
    _isoCodeSignUpController.close();
    _submitSignUpController.close();
  }
}
