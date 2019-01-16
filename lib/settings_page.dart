import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/main.dart';

class SettingsPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySettingsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MySettingsPage extends StatefulWidget {
  MySettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  void _incrementCounter() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration:
                BoxDecoration(gradient: MadarColors.gradiant_decoration),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                      child: Text(
                        "Some Slogan about Madar",
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Container(
                      height: 180,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                print("pressed");
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Contact us",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                print("pressed");
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Privacy Policy",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                print("pressed");
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Push Notifications",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Container(
                            constraints: BoxConstraints.expand(height: 50),
                            child: FlatButton(
                              onPressed: () {
                                BlocProvider.of<AppBloc>(context).logout;
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 24.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
