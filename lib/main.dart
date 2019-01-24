import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/auth_page.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/trip_planning/Trip_planing_page.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataStore.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key key, this.prefs})
      : assert(prefs != null),
        super(key: key);

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  AppBloc bloc;
  Key key;

  @override
  initState() {
    key = UniqueKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = AppBloc(widget.prefs);
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder<bool>(
          stream: bloc.logOutStream,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  bloc.pushStopLoop;
                  key = UniqueKey();
                });
              });
            }

            return MaterialApp(
              key: key,
              debugShowCheckedModeBanner: false,
              supportedLocales: [
                const Locale('en', 'US'),
                const Locale('ar', ''),
              ],
              localizationsDelegates: [
                const MadarLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeResolutionCallback:
                  (Locale locale, Iterable<Locale> supportedLocales) {
                for (Locale supportedLocale in supportedLocales) {
                  if (locale != null) if (supportedLocale.languageCode ==
                          locale.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    print(supportedLocale);
                    return supportedLocale;
                  }
                }

                return supportedLocales.first;
              },
              title: 'Flutter Demo',
              theme: ThemeData(primaryColor: MadarColors.gradientDown, fontFamily: 'cairo'),
              initialRoute: '/',
              routes: {
                '/': (context) => LandingPage(),
                HomePage.route: (context) => HomePage(),
              },
              // home: TripPlanningPage(),
            );
          }),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    bloc.pushUser;
    return StreamBuilder<bool>(
      stream: bloc.authenticationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(HomePage.route);
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => AuthPage()));
            });
          }
        }
        return Container(
          color: Colors.green,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        );
      },
    );
  }
}
