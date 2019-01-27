import 'package:madar_booking/models/user.dart';

class UserResponse {
  final String token;
  final User user;

  UserResponse(this.token, this.user);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json['id'],
      User.fromJson(json['user']),
    );
  }
}
