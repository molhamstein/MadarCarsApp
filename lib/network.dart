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
}
