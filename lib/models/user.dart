class User {
  static const ID = 'id';
  static const USER_NAME = 'username';
  static const PHONE_NUMBER = 'phoneNumber';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  final String id;
  final String userName;
  final String phoneNumber;
  final String status;
  final String createdAt;

  User(this.id, this.userName, this.phoneNumber, this.status, this.createdAt);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['username'],
      json['phoneNumber'],
      json['status'],
      json['createdAt'],
    );
  }
}
