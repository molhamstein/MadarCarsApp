import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/media.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'validator.dart';

class AuthBloc extends BaseBloc with Validators, Network {
  bool shouldShowFeedBack;
  bool shouldNavgateToSignUp;

  AuthBloc(
      {this.shouldShowFeedBack = true, this.shouldNavgateToSignUp = false});

  final _phoneLoginController = BehaviorSubject<String>();
  final _passwordLoginController = BehaviorSubject<String>();

  final _phoneSignUpController = BehaviorSubject<String>();
  final _passwordSignUpController = BehaviorSubject<String>();
  final _nameSignUpController = BehaviorSubject<String>();
  final _isoCodeSignUpController = BehaviorSubject<CountryCode>();
  final _SocialLoginController = BehaviorSubject<SocialUser>();
  final _loadingController = BehaviorSubject<bool>();

  final _obscureLoginPasswordController =
      BehaviorSubject<bool>(seedValue: true);

  final _obscureSignUpPassword = BehaviorSubject<bool>(seedValue: true);
  final _obscureSignUpPasswordConfirmation =
      BehaviorSubject<bool>(seedValue: true);

  final _submitLoginController = PublishSubject<UserResponse>();
  final _submitSignUpController = PublishSubject<UserResponse>();
  final _submitUpdateUserController = PublishSubject<User>();
  final _uploadMediaContoller = BehaviorSubject<Media>();

  final _lockTouchEventController = BehaviorSubject<bool>();
  final _updateSuccessController = BehaviorSubject<bool>();

  get pushUpdateSuccessEvent => _updateSuccessController.sink.add(true);

  get pushUpdateFaildEvent => _updateSuccessController.sink.add(false);

  Stream<SocialUser> get facebookUserStream => _SocialLoginController.stream;

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

  Stream<CountryCode> get countryCodeChangeStream =>
      _isoCodeSignUpController.stream;

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

  Stream<bool> get userUpdateStream => _updateSuccessController.stream;

  Stream<bool> get loadingStream => _loadingController.stream;

  get startLoading => _loadingController.sink.add(true);

  get stopLoading => _loadingController.sink.add(false);

//
//  checkNumber(){
//    final validPhoneNumber = _phoneLoginController.value;
//    final validIsoCode = _isoCodeSignUpController.value;
//    checkNum(validIsoCode.dialCode+validPhoneNumber).then((s) {
//      _checkNumController.sink.add(s);
//      stopLoading;
//    }).catchError((e) {
//      shouldShowFeedBack = true;
//      print(e);
//      pushUnlockTouchEvent;
//      _checkNumController.sink.addError(e);
//      stopLoading;
//      Future.delayed(Duration(milliseconds: 100)).then((_) {
//        startLoading;
//      });
//    });
//
//  }

  submitLogin() {
    final validPhoneNumber = _phoneLoginController.value;
    final validPassword = _passwordLoginController.value;
    final validIsoCode = _isoCodeSignUpController.value;

    pushLockTouchEvent;
    startLoading;

    login(validIsoCode.dialCode + validPhoneNumber, validPassword)
        .then((response) {
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

  final _checkNumController = BehaviorSubject<bool>();

  get checkNumStream => _checkNumController.stream;

  final getCountryCode = BehaviorSubject<String>();

  get countryCode => getCountryCode.stream;

  fetchCheckNum() {
    final validPhoneNumber = _phoneLoginController.value;
    final validIsoCode = _isoCodeSignUpController.value;
    getCountryCode.sink.add(validIsoCode.code);
    print("on check" + getCountryCode.value);
    startLoading;
    checkNum(validIsoCode.dialCode + validPhoneNumber).then((result) {
      if (result == "true") {
        print("resulte is :" + result);
        _checkNumController.sink.add(true);
        shouldNavgateToSignUp = false;
      } else {
        print("resulte is :" + result);
        _checkNumController.sink.add(false);
        shouldNavgateToSignUp = true;
      }

      stopLoading();
    }).catchError((e) {});
  }

  submitSignUp() {
    final validUserName = _nameSignUpController.value;
    final validPhoneNumber = _phoneSignUpController.value;
    final validPassword = _passwordSignUpController.value;
    final validIsoCode = _isoCodeSignUpController.value;
    pushLockTouchEvent;

    signUp(validPhoneNumber, validUserName, validPassword, validIsoCode)
        .then((user) {
      login(validIsoCode.dialCode + validPhoneNumber, validPassword)
          .then((response) {
        _submitSignUpController.sink.add(response);
        stopLoading;
        pushUnlockTouchEvent;
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      this.shouldShowFeedBack = true;
      stopLoading;
      pushUnlockTouchEvent;
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        startLoading;
      });

      if (e == ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED) {
        _submitSignUpController.sink
            .addError("PHONENUMBER_OR_USERNAME_IS_USED");
      } else {
        print(e);
        _submitSignUpController.sink.addError(e);
      }
      print(e);
    });
  }

  submitUpdateUserWithImage(File image, token, userId) {
    upload(image, token).then((response) {
      print(response);
      _uploadMediaContoller.sink.add(response);
      if (response != null) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('user_image', response.url);
          submitUpdateUser(userId, token, response.id);
        });
      } else {
        stopLoading;
        //   pushUnlockTouchEvent;
      }
    }).catchError((e) {
      shouldShowFeedBack = true;
      //  pushUnlockTouchEvent;
      _uploadMediaContoller.sink.addError(e);
      stopLoading;
    });
  }

  submitUpdateUser(userId, token, imageId) {
    final validUserName = _nameSignUpController.value;
    final validPhoneNumber = _phoneSignUpController.value;
    final validIsoCode = _isoCodeSignUpController.value.code;
    // pushLockTouchEvent;
    startLoading;
    updateUser(userId, validPhoneNumber, validUserName, validIsoCode, token,
            imageId)
        .then((user) {
      print(user);
      //   pushUnlockTouchEvent;
      pushUpdateSuccessEvent;
      _submitUpdateUserController.sink.add(user);
      stopLoading;
    }).catchError((e) {
      //  pushUnlockTouchEvent;
      pushUpdateFaildEvent;
      shouldShowFeedBack = true;
      _submitUpdateUserController.sink.addError(e);
      stopLoading;
    });
  }

  loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        getFacebookProfile(result.accessToken.token).then((jsonProfile) {
          print(jsonProfile);
          SocialUser facebookUser = SocialUser(
              jsonProfile['name'],
              jsonProfile['email'],
              jsonProfile['id'],
              result.accessToken.token,
              UserSocialLoginType.facebook);
          facebookSignUp(facebookUser.id, facebookUser.token)
              .then((userResponse) {
            print('user name : ' + userResponse.user.name);
            _submitLoginController.sink.add(userResponse);
          }).catchError((e) {
            print(e);
            if (e == ErrorCodes.NOT_COMPLETED_SN_LOGIN) {
              _SocialLoginController.sink.add(facebookUser);
            }
          });
        }).catchError((e) {
          print(e);
          _SocialLoginController.addError(e);
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

  loginWithGoogle() {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    googleSignIn.signIn().then((account) {
      account.authentication.then((auth) {
        SocialUser googleUser = SocialUser(account.displayName, account.email,
            account.id, auth.accessToken, UserSocialLoginType.google);

        googleSignUp(account.id, auth.accessToken).then((userResponse) {
          print('user name : ' + userResponse.user.name);
          _submitLoginController.sink.add(userResponse);
        }).catchError((e) {
          print(e);
          if (e == ErrorCodes.NOT_COMPLETED_SN_LOGIN) {
            _SocialLoginController.sink.add(googleUser);
            print(e);
          }
        });
      }).catchError((e) => print(e));
    }).catchError((e) => print(e));
  }

  dispose() {
//    _phoneLoginController.close();
//    _passwordLoginController.close();
//    _obscureSignUpPassword.close();
//    _obscureSignUpPasswordConfirmation.close();
//    _obscureLoginPasswordController.close();
//    _submitLoginController.close();
//    _lockTouchEventController.close();
//    _phoneSignUpController.close();
//    _nameSignUpController.close();
//    _passwordSignUpController.close();
//    _isoCodeSignUpController.close();
//    _submitSignUpController.close();
//    _SocialLoginController.close();
//    _loadingController.close();
//    _uploadMediaContoller.close();
//    _submitUpdateUserController.close();
    _checkNumController.close();
  }
}

class SocialUser {
  final String name;
  final String email;
  final String id;
  final String token;
  final UserSocialLoginType type;

  SocialUser(this.name, this.email, this.id, this.token, this.type);
}

enum UserSocialLoginType { google, facebook }
