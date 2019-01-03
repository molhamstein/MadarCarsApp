class User {
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