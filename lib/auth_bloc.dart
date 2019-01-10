import 'dart:async';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
  final _isoCodeSignUpController = BehaviorSubject<CountryCode>();
  final _facebookLoginController = BehaviorSubject<FacebookUser>();

  final _obscureLoginPasswordController =
      BehaviorSubject<bool>(seedValue: true);

  final _obscureSignUpPassword = BehaviorSubject<bool>(seedValue: true);
  final _obscureSignUpPasswordConfirmation =
      BehaviorSubject<bool>(seedValue: true);

  final _submitLoginController = BehaviorSubject<User>();
  final _submitSignUpController = BehaviorSubject<User>();

  final _lockTouchEventController = BehaviorSubject<bool>();

  Stream<FacebookUser> get facebookUserStream =>
      _facebookLoginController.stream;

  get pushLockTouchEvent => _lockTouchEventController.sink.add(true);

  Function(String) get changeLoginPhone => _phoneLoginController.sink.add;

  Function(String) get changeLoginPassword => _passwordLoginController.sink.add;

  Function(String) get changeSignUpPhone => _phoneSignUpController.sink.add;

  Function(String) get changeSignUpUserName => _nameSignUpController.sink.add;

  Function(String) get changeSignUpPassword =>
      _passwordSignUpController.sink.add;

  Function(CountryCode) get changeSignUpIsoCode =>
      _isoCodeSignUpController.sink.add;

  Stream<String> get phoneSignUpStream =>
      _phoneSignUpController.stream.transform(validatePhone);

  Stream<String> get nameSignUpStream =>
      _nameSignUpController.stream.transform(validateName);

  Stream<String> get passwordSignUpStream =>
      _passwordSignUpController.stream.transform(validatePassword);

  get pushObscureSignUpPassword =>
      _obscureSignUpPassword.sink.add(!_obscureSignUpPassword.value);

  Stream<bool> get obscureSignUpPasswordStream => _obscureSignUpPassword.stream;

  get pushObscureSignUpPasswordConfirmation =>
      _obscureSignUpPasswordConfirmation.sink
          .add(!_obscureSignUpPasswordConfirmation.value);

  Stream<bool> get obscureSignUpPasswordConfirmationStream =>
      _obscureSignUpPasswordConfirmation.stream;

  get pushObscureLoginPassword => _obscureLoginPasswordController.sink
      .add(!_obscureLoginPasswordController.value);

  Stream<bool> get obscureLoginPasswordStream =>
      _obscureLoginPasswordController.stream;

  Stream<String> get phoneLoginStream =>
      _phoneLoginController.stream.transform(validatePhone);

  Stream<String> get passwordLoginStream =>
      _passwordLoginController.stream.transform(validatePassword);

  Stream<bool> get submitValidLogin => Observable.combineLatest2(
      phoneLoginStream, passwordLoginStream, (a, b) => true);

  Stream<bool> get submitValidSignUp => Observable.combineLatest3(
      phoneSignUpStream,
      passwordSignUpStream,
      nameSignUpStream,
      (a, b, c) => true);

  Stream<User> get submitLoginStream => _submitLoginController.stream;

  Stream<User> get submitSignUpStream => _submitSignUpController.stream;

  Stream<bool> get lockTouchEventStream => _lockTouchEventController.stream;

  submitLogin() {
    final validPhoneNumber = _phoneLoginController.value;
    final validPassword = _passwordLoginController.value;
    pushLockTouchEvent;

    login('0957465877', 'password').then((response) {
      //TODO: put real values (from controller).
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
    final validIsoCode = _isoCodeSignUpController.value.code;
    pushLockTouchEvent;

    signUp(validPhoneNumber, validUserName, validPassword, validIsoCode)
        .then((user) {
      login(validPhoneNumber, validPassword).then((response) {
        _submitSignUpController.sink.add(response.user);
      }).catchError((e) {
        print(e);
        _submitSignUpController.sink.addError(e);
      });
    }).catchError((e) {
      _submitSignUpController.sink.addError(e);
    });
  }

  loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        getFacebookProfile(result.accessToken.token).then((jsonProfile) {
          FacebookUser facebookUser =
              FacebookUser.fromJson(jsonProfile, result.accessToken.token);
          facebookSignUp(facebookUser.id, facebookUser.token).then((user) {
            print('user name : ' + user.userName);
            _submitLoginController.sink.add(user);
          }).catchError((e) {
            print(e);
            if (e == ErrorCodes.NOT_COMPLETED_SN_LOGIN) {
              _facebookLoginController.sink.add(facebookUser);
            }
          });

          print(facebookUser.id);
        }).catchError((e) {
          print(e);
          _facebookLoginController.addError(e);
        });

        break;
      case FacebookLoginStatus.cancelledByUser:
        print(result.status);
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  dispose() {
    _phoneLoginController.close();
    _passwordLoginController.close();
    _obscureSignUpPassword.close();
    _obscureSignUpPasswordConfirmation.close();
    _obscureLoginPasswordController.close();
    _submitLoginController.close();
    _lockTouchEventController.close();
    _phoneSignUpController.close();
    _nameSignUpController.close();
    _passwordSignUpController.close();
    _isoCodeSignUpController.close();
    _submitSignUpController.close();
    _facebookLoginController.close();
  }
}

class FacebookUser {
  final String name;
  final String email;
  final String id;
  final String token;

  FacebookUser(this.name, this.email, this.id, this.token);

  factory FacebookUser.fromJson(Map<String, dynamic> json, String token) {
    return FacebookUser(json['name'], json['email'], json['id'], token);
  }
}
