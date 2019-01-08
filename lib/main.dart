import 'package:flutter/material.dart';
import 'package:madar_booking/after_facebook_auth.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataStore.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //DataStore.init();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  int counter = 0; //DataStore().counter ?? 0;

  MyApp({Key key, this.prefs})
      : assert(prefs != null),
        super(key: key);

  void incress() {
    print(counter);
    //  DataStore().counter++;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
        ));
  }
}
