import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/SignUp.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/network.dart';
import 'package:madar_booking/submitButton.dart';

class CheckGsm extends StatefulWidget {
  @override
  _CheckGsmState createState() => _CheckGsmState();
}

class _CheckGsmState extends State<CheckGsm>
    with UserFeedback, SingleTickerProviderStateMixin, Network {
  AuthBloc bloc;
  AppBloc appBloc;

  Animation animation;

  AnimationController animationController;

  final FocusNode myFocusNodeEmailLogin = FocusNode();

  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();

  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    bloc = AuthBloc();
    appBloc = BlocProvider.of<AppBloc>(context);

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween(begin: 0, end: 500.0).animate(animationController);
//    checkNum();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserResponse>(
          stream: bloc.submitLoginStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              appBloc.saveUser(snapshot.data.user);
              appBloc.saveToken(snapshot.data.token);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => HomePage(
                          afterLogin: true,
                        )));
              });
            }
            if (snapshot.hasError && bloc.shouldShowFeedBack) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
//                showInSnackBar(snapshot.error.toString(), context,
//                    color: Colors.redAccent);
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => SignUp()));
                bloc.shouldShowFeedBack = false;
              });
            }
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        MadarColors.gradientUp,
                        MadarColors.gradientDown
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 75.0),
                      child: Container(
                        width: 250.0,
                        height: 170.0,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: new Text(
                              MadarLocalizations.of(context).trans(
                                  'Your_best_companion_for_a_comfortable_trip_to_turkey'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: "WorkSansMedium",
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 23.0),
                      child: StreamBuilder<bool>(
                          stream: bloc.checkNumStream,
                          builder: (context, snapshot) {
                            var valid = (snapshot.hasData && snapshot.data);
                            print(valid);

                            return Column(
                              /// Suronded coulnm
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Card(
                                          elevation: 2.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Container(
                                            width: 300,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    child: phoneTextField()),
                                                Container(
                                                  width: 250.0,
                                                  height: 1.0,
                                                  color: Colors.grey[400],
                                                ),
                                                StreamBuilder<bool>(
                                                    stream: bloc.checkNumStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData &&
                                                          snapshot.data ==
                                                              true) {
                                                        print("data is true");
                                                        return passwordTextField();
                                                      } else if (snapshot
                                                              .hasData &&
                                                          snapshot.data ==
                                                              false) {
                                                        print("data is false");
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  new MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              SignUp()));
                                                        });
                                                      } else {
                                                        return Container();
                                                      }
                                                    })
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50.0, bottom: 30),
                                  child: valid ? loginBtn() : checkBtn(),
                                ),
                              ],
                            );
                          }),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 150.0, top: 8),
//                      child: new Text(
//                        "Forget password ?",
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 16.0,
//                            fontFamily: "WorkSansMedium",
//                            decoration: TextDecoration.none),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 50.0, bottom: 30),
//                      child: loginBtn(),
//                    ),
//                    checkBtn(),
//                    StreamBuilder<String>(
//                        stream: bloc.checkNumStream,
//                        builder: (context, snapshot) {
//                    TextField(
//                      controller: _controller,
////                            onSubmitted: (s) {
////                              bloc.fetchCheckNum(s);
//////                            StreamBuilder<String>(  stream: bloc.checkNumStream,
//////                                builder: (context, snapshot) {
//////                                  print("i'm in"+ snapshot.data.toString());
//////
////
////                              if (snapshot.hasData) {
////                                print("data");
////                                print("data is " + snapshot.data.toString());
////                                if (snapshot.data.toString() == "true") {
////                                  print("i'm true");
////                                } else if (snapshot.data.toString() ==
////                                    "false") {
////                                  Navigator.of(context).pushReplacement(
////                                      new MaterialPageRoute(
////                                          builder: (context) => SignUp()));
////                                }
////                              } else
////                                print("No data");
//////                            });
//////                            print("blooooc valll "  +  bloc.checkNumStream.toString());
////
//////                        print("M" +Network.M);
//////                        if(Network.M == "true")
//////                          {print("truuuuuuuuuuuuuuue");}
////                            },
//                    ),
//
//                    StreamBuilder<String>(
//                        stream: bloc.checkNumStream,
//                        builder: (context, snapshot) {
//                          print(snapshot.data);
//                          if (snapshot.hasData)
//                            return Text("Yes");
//                          else
//                            return Text("Noooo");
//                        }),
//                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _navigateToSignUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => CheckGsm()));
    });
  }

  Widget checkBtn() {
    return StreamBuilder<bool>(
        stream: bloc.loadingStream,
        initialData: false,
        builder: (context, loadingSnapshot) {
          return SubmitButton(
            text: MadarLocalizations.of(context).trans('submit'),
            onPressed: () {
              if (!(loginEmailController.text.isNotEmpty)) {
                showInSnackBar('error_provide_valid_info', context,
                    color: Colors.redAccent);
                bloc.shouldShowFeedBack = false;
              } else {
                bloc.fetchCheckNum();
              }
            },
            width: 150,
            height: 50,
            loading: loadingSnapshot.data,
          );
        });
  }

  Widget loginBtn() {
    return StreamBuilder<bool>(
      stream: bloc.submitValidLogin,
      initialData: false,
      builder: (context, snapshot) {
        return StreamBuilder<bool>(
            stream: bloc.loadingStream,
            initialData: true,
            builder: (context, loadingSnapshot) {
              return SubmitButton(
                text: MadarLocalizations.of(context).trans('submit'),
                onPressed: () {
                  if ((!snapshot.hasData || !snapshot.data)) {
                    showInSnackBar('error_provide_valid_info', context,
                        color: Colors.redAccent);
                    bloc.shouldShowFeedBack = false;
                  } else {
                    bloc.submitLogin();
                  }
                },
                width: 150,
                height: 50,
                loading: (snapshot.data == null ? false : snapshot.data) &&
                    loadingSnapshot.data,
              );
            });
      },
    );
  }

//
//  Widget loginBtn() {
////    return StreamBuilder<bool>(
////      stream: bloc.submitValidLogin,
////      initialData: false,
////      builder: (context, snapshot) {
////        return StreamBuilder<bool>(
////            stream: bloc.loadingStream,
////            initialData: true,
////            builder: (context, loadingSnapshot) {
//    return SubmitButton(
//      text: MadarLocalizations.of(context).trans('submit'),
//                onPressed: () {
//                  if ((!snapshot.hasData || !snapshot.data)) {
//                    showInSnackBar('error_provide_valid_info', context,
//                        color: Colors.redAccent);
//                    bloc.shouldShowFeedBack = false;
//                  } else
//                    bloc.submitLogin();
//                },
//      width: 150,
//      height: 50,
//    ),
//                loading: (snapshot.data == null ? false : snapshot.data) &&
//                    loadingSnapshot.data,
//              );
//            });
//      },
//    );
//  }

  Widget passwordTextField() {
    return StreamBuilder<String>(
      stream: bloc.passwordLoginStream,
      builder: (context, passwordSnapshot) {
        return StreamBuilder<bool>(
          initialData: true,
          stream: bloc.obscureLoginPasswordStream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0),
              child: Container(
                height: 60,
                child: TextField(
                  focusNode: myFocusNodePasswordLogin,
                  controller: loginPasswordController,
//                    obscureText: true,
                  obscureText: snapshot.data,
                  onChanged: bloc.changeLoginPassword,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      FontAwesomeIcons.lock,
                      size: 22.0,
                      color: Colors.black,
                    ),
                    errorText: MadarLocalizations.of(context)
                        .trans(passwordSnapshot.error),
                    hintText: MadarLocalizations.of(context).trans('password'),
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                    suffixIcon: GestureDetector(
                      onTap: () => bloc.pushObscureLoginPassword,
                      child: Icon(
                        FontAwesomeIcons.eye,
                        size: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
      stream: bloc.phoneLoginStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: Container(
            height: 60,
            child: Localizations(delegates: [  GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate,],locale: Locale('en', '') ,
              child: TextField(
                focusNode: myFocusNodeEmailLogin,
                controller: loginEmailController,
                keyboardType: TextInputType.phone,
                onChanged: bloc.changeLoginPhone,
                style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: MadarLocalizations.of(context).trans(snapshot.error),
                  errorStyle: TextStyle(height: 0.1, fontSize: 12),
                  icon: isoCodePicker(),
                  hintText: MadarLocalizations.of(context).trans('phone_number'),
                  hintStyle:
                      TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//
  Widget isoCodePicker() {
    return CountryCodePicker(
      favorite: ['SA', 'TR', 'KW', 'AE'],
      initialSelection: 'SA',
      onChanged: bloc.changeSignUpIsoCode,
    );
  }
}
