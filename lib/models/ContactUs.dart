class ContactUs {
  String _contactUsNum;

  ContactUs(this._contactUsNum);

  String get contactUsNumber => _contactUsNum;

  ContactUs.fromJson(Map<String, dynamic> json) {
    _contactUsNum = json['contactUsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactUsNumber'] = this._contactUsNum;
    return data;
  }
}
