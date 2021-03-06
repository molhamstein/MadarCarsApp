import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/Invoice.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/network.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends BaseBloc with Network {
  final token;
  ProfileBloc(this.token);
  // myTrips Bloc
  final _myTripsController = BehaviorSubject<List<MyTrip>>();
  Function(List<MyTrip>) get insertTripsList => _myTripsController.sink.add;
  Stream<List<MyTrip>> get myTripsStream => _myTripsController.stream;

  // invoice

  final _invoiceController = BehaviorSubject<Invoice>();
  Function(Invoice) get insertInvoice => _invoiceController.sink.add;
  Stream<Invoice> get invoiceStream => _invoiceController.stream;

  final _userController = BehaviorSubject<User>();
  Function(User) get insertuser => _userController.sink.add;
  Stream<User> get userStream => _userController.stream;

  Future myTrips() {
    return getMyTrips(token).then((response) {
      print(response);
      _myTripsController.sink.add(response);
    }).catchError((e) {
      print(e);
      _myTripsController.sink.addError(e);
    });
  }

  invoice(String tripId) {
    getInvoice(token, tripId).then((response) {
      print(response);
      _invoiceController.sink.add(response);
    }).catchError((e) {
      print(e);
      _invoiceController.sink.addError(e);
    });
  }

  getMe() {
    getUserProfile(token).then((response) {
      print(response);
      // saveUser(response);
      _userController.sink.add(response);
    }).catchError((e) {
      print(e);
      _userController.sink.addError(e);
    });
  }

  saveUser(User user) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (user.media != null) _prefs.setString('user_image', user.media.url);
    print("save user");
    _prefs.setString("user", userToJson(user));
  }

  @override
  void dispose() {
    _myTripsController.close();
    _invoiceController.close();
    _userController.close();
  }
}
