import 'package:flutter/material.dart';
import 'package:madar_booking/step2_sign_up.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key key, this.prefs})
      : assert(prefs != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc(prefs),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthPage(),
      ),
    );
  }
}
