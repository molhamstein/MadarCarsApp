import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/user.dart';

class Network {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static final String _baseUrl = 'http://104.217.253.15:3006/api/';
  final String _loginUrl = _baseUrl + 'users/login?include=user';
  final String _signUpUrl = _baseUrl + 'users';
  final String _facebookLoginUrl = _baseUrl + 'users/facebookLogin';

  Future<UserResponse> login(String phoneNumber, String password) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'password': password,
    });
    final response = await http.post(
        _loginUrl,
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }


  Future<User> signUp(String phoneNumber, String userName, String password, String isoCode) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'username': userName,
      'password': password,
      'ISOCode': isoCode
    });
    final response = await http.post(_signUpUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<dynamic> getFacebookProfile(String token) async {
    final response = await http.get(
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=" +
          token,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw json.decode(response.body);
    }
  }

  Future<User> facebookSignUp(String facebookId, String facebookToken) async {
    final body = json.encode({
      'socialId': facebookId,
      'token': facebookToken,
    });
    final response = await http.post(_facebookLoginUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return User.fromJson(json.decode(response.body)['user']);
    } else if(response.statusCode == ErrorCodes.NOT_COMPLETED_SN_LOGIN) {
      throw ErrorCodes.NOT_COMPLETED_SN_LOGIN;
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

  Future<User> step2FacebookSignUp(String phoneNumber, String isoCode, String facebookId, String facebookToken, String facebookUsername) async {
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'username': facebookUsername,
      'socialId': facebookId,
      'token': facebookToken,
      'ISOCode': isoCode,
    });
    final response = await http.post(_facebookLoginUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }

}

mixin ErrorCodes {

  static const int NOT_COMPLETED_SN_LOGIN = 450;

}
