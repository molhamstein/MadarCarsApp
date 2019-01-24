import 'dart:async';
import 'dart:io';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/media.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'validator.dart';

class AuthBloc extends BaseBloc with Validators, Network {
  bool shouldShowFeedBack;

  Authbloc() {
    shouldShowFeedBack = true;
  }

  final _phoneLoginController = BehaviorSubject<String>();
  final _passwordLoginController = BehaviorSubject<String>();

  final _phoneSignUpController = BehaviorSubject<String>();
  final _passwordSignUpController = BehaviorSubject<String>();
  final _nameSignUpController = BehaviorSubject<String>();
  final _isoCodeSignUpController = BehaviorSubject<CountryCode>();
  final _facebookLoginController = BehaviorSubject<FacebookUser>();
  final _loadingController = BehaviorSubject<bool>();

  final _obscureLoginPasswordController =
      BehaviorSubject<bool>(seedValue: true);

  final _obscureSignUpPassword = BehaviorSubject<bool>(seedValue: true);
  final _obscureSignUpPasswordConfirmation =
      BehaviorSubject<bool>(seedValue: true);

  final _submitLoginController = PublishSubject<UserResponse>();
  final _submitSignUpController = BehaviorSubject<UserResponse>();
  final _submitUpdateUserController = BehaviorSubject<User>();
  final _uploadMediaContoller = BehaviorSubject<Media>();

  final _lockTouchEventController = BehaviorSubject<bool>();

  Stream<FacebookUser> get facebookUserStream =>
      _facebookLoginController.stream;

  get pushLockTouchEvent => _lockTouchEventController.sink.add(true);
  get pushUnlockTouchEvent => _lockTouchEventController.sink.add(false);

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
  Stream<bool> get submitValidEditUser => Observable.combineLatest2(
      phoneSignUpStream, nameSignUpStream, (a, b) => true);
// _submitUpdateUserController
  Stream<UserResponse> get submitLoginStream => _submitLoginController.stream;

  Stream<UserResponse> get submitSignUpStream => _submitSignUpController.stream;
  Stream<User> get submitUpdteUserStream => _submitUpdateUserController.stream;

  Stream<bool> get lockTouchEventStream => _lockTouchEventController.stream;

  Stream<bool> get loadingStream => _loadingController.stream;

  get startLoading => _loadingController.sink.add(true);
  get stopLoading => _loadingController.sink.add(false);

  submitLogin() {
    final validPhoneNumber = _phoneLoginController.value;
    final validPassword = _passwordLoginController.value;
    pushLockTouchEvent;

    login(validPhoneNumber, validPassword).then((response) {
      print(response.token);
      _submitLoginController.sink.add(response);
      stopLoading;
    }).catchError((e) {
      shouldShowFeedBack = true;
      print(e);
      pushUnlockTouchEvent;
      _submitLoginController.sink.addError(e);
      stopLoading;
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        startLoading;
      });
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
        _submitSignUpController.sink.add(response);
        stopLoading;
        pushUnlockTouchEvent;
      }).catchError((e) {

        print(e);

      });
    }).catchError((e) {
      shouldShowFeedBack = true;
      stopLoading;
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        startLoading;
      });
      pushUnlockTouchEvent;

      if (e == ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED) {
        _submitSignUpController.sink
            .addError('Phone number or Username are used');

      }
      else {
        _submitSignUpController.sink.addError(e);
      }
      print(e);

    });
  }

  updateImage(File image, token, userId) {
    upload(image, token).then((response) {
      print(response);
      _uploadMediaContoller.sink.add(response);
      submitUpdateUser(userId, token, response.id);
    }).catchError((e) {
      _uploadMediaContoller.sink.addError(e);
    });
  }

  submitUpdateUser(userId, token, imageId) {
    final validUserName = _nameSignUpController.value;
    final validPhoneNumber = _phoneSignUpController.value;
    final validIsoCode = _isoCodeSignUpController.value.code;
    pushLockTouchEvent;

    updateUser(userId, validPhoneNumber, validUserName, validIsoCode, token,
            imageId)
        .then((user) {
      print(user);
      // login(validPhoneNumber, validPassword).then((response) {
      _submitUpdateUserController.sink.add(user);
      // }).catchError((e) {
      //   print(e);
      //   _submitSignUpController.sink.addError(e);
      // });
    }).catchError((e) {
      if (e == ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED)
        _submitUpdateUserController.sink
            .addError('Phone number or Username are used');
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
          print(jsonProfile);
          FacebookUser facebookUser =
              FacebookUser.fromJson(jsonProfile, result.accessToken.token);
          facebookSignUp(facebookUser.id, facebookUser.token)
              .then((userResponse) {
            print('user name : ' + userResponse.user.name);
            _submitLoginController.sink.add(userResponse);
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
    _loadingController.close();
    _uploadMediaContoller.close();
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
