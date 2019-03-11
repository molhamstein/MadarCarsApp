class CheckCoupon {
  String _code;
  String _from;
  String _to;
  String _status;
  int _numberOfUses;
  int _numberOfUsed;
  int _value;
  String _type;
  String _createdAt;
  String _id;
  String _travelAgencyId;

  CheckCoupon.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _from = json['from'];
    _to = json['to'];
    _status = json['status'];
    _numberOfUses = json['numberOfUses'];
    _numberOfUsed = json['numberOfUsed'];
    _value = json['value'];
    _type = json['type'];
    _createdAt = json['createdAt'];
    _id = json['id'];
    _travelAgencyId = json['travelAgencyId'];
  }
}
