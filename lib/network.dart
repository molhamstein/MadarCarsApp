import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:madar_booking/models/UserResponse.dart';

class Network {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static final String _baseUrl = 'http://104.217.253.15:3006/api/';
  final String _loginUrl = _baseUrl + 'users/login?include=user';

  Future<UserResponse> login(String phoneNumber, String password) async {
    var body = json.encode({
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
}
