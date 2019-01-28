import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/MainButton2.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/user.dart';
import 'package:madar_booking/step2_sign_up.dart';
import 'feedback.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> with UserFeedback {
  final FocusNode myFocusNodeEmailLogin = FocusNode();

  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();

  TextEditingController loginPasswordController = new TextEditingController();

  AuthBloc bloc;
  AppBloc appBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      // feedback the user about the server response.
      stream: bloc.submitLoginStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          appBloc.saveUser(snapshot.data.user);
          appBloc.saveToken(snapshot.data.token);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
        if (snapshot.hasError && bloc.shouldShowFeedBack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInSnackBar(snapshot.error.toString(), context,
                color: Colors.redAccent);
            bloc.shouldShowFeedBack = false;
          });
        }

        return Container(
          padding: EdgeInsets.only(top: 23.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 180.0,
                      child: Column(
                        children: <Widget>[
                          phoneTextField(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          passwordTextField(),
                        ],
                      ),
                    ),
                  ),
                  loginBtn(),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white10,
                              Colors.white,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        MadarLocalizations.of(context).trans('or'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white10,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 40.0, left: 40),
                    child: GestureDetector(
                      onTap: () => bloc.loginWithFacebook(),
                      child: StreamBuilder<FacebookUser>(
                          stream: bloc.facebookUserStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showInSnackBar(
                                    snapshot.error.toString(), context);
                              });
                            }
                            if (snapshot.hasData) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
//                              showInSnackBar(snapshot.data.toString(), context);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return Step2SignUp(
                                    socialId: snapshot.data.id,
                                    socialToken: snapshot.data.token,
                                    userName: snapshot.data.name,
                                  );
                                }));
                              });
                              return CircularProgressIndicator();
                            }
                            return Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: new Icon(
                                FontAwesomeIcons.facebookF,
                                color: Color(0xFF0084ff),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 40,
                      right: 40.0,
                    ),
                    child: GestureDetector(
//                  onTap: () => showInSnackBar("Google button pressed"),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: new Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFF0084ff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                errorStyle: TextStyle(height: 0.2),
                icon: isoCodePicker(),
                hintText: MadarLocalizations.of(context).trans('phone_number'),
                hintStyle:
                    TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
              ),
            ),
          ),
        );
      },
    );
  }

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

  Widget isoCodePicker() {
    return CountryCodePicker(
      favorite: ['SA', 'TR', 'KW', 'AE'],
      initialSelection: 'SA',
      onChanged: bloc.changeSignUpIsoCode,
      padding: EdgeInsets.all(0),
    );
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
              return MainButton2(
                text: MadarLocalizations.of(context).trans('submit'),
                onPressed: () {
                  if ((!snapshot.hasData || !snapshot.data)) {
                    showInSnackBar('error_provide_valid_info', context,
                        color: Colors.redAccent);
                    bloc.shouldShowFeedBack = false;
                  } else
                    bloc.submitLogin();
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
}
