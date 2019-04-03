import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/submitButton.dart';

class SignUp extends StatefulWidget {
  final String number;
  final String code;

  SignUp({Key key, this.number ,this.code}) : super(key: key);

  @override
  SignUpState createState() {
    return new SignUpState();
  }
}

class SignUpState extends State<SignUp> with UserFeedback {
  final FocusNode myFocusNodePassword = FocusNode();

  final FocusNode myFocusNodeEmail = FocusNode();

  final FocusNode myFocusNodeName = FocusNode();

  final TextEditingController signupEmailController =
      new TextEditingController();

  final TextEditingController signupNameController =
      new TextEditingController();

  final TextEditingController signupPasswordController =
      new TextEditingController();

  final TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  AppBloc appBloc;
  AuthBloc bloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    bloc = AuthBloc();
    super.initState();
    print(widget.code);
    print(widget.number);
    signupEmailController.text = widget.number;
    bloc.changeSignUpPhone(signupEmailController.text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder<UserResponse>(
              stream: bloc.submitSignUpStream,
              builder: (context, snapshot) {
                if (snapshot.hasError && bloc.shouldShowFeedBack) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showInSnackBar(snapshot.error.toString(), context,
                        color: Colors.redAccent);
                  });
                  bloc.shouldShowFeedBack = false;
                }
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
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                        Container(
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
                                      child: Column(
                                        children: <Widget>[
                                          nameTextField(),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 30),
                          child: signUpBtn(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ))
        ],
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeName,
        controller: signupNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpUserName,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.user,
            color: Colors.black,
          ),
          hintText: MadarLocalizations.of(context).trans('name'),
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
        stream: bloc.phoneSignUpStream,
        builder: (context, phoneSnapshot) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: StreamBuilder<CountryCode>(
                  stream: bloc.countryCodeChangeStream,
                  initialData: CountryCode(code: 'SA', dialCode: '+966'),
                  builder: (context, snapshot) {
                    return

                        Localizations(
                      delegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      locale: Locale('en', ''),
                      child: TextField(
                        focusNode: myFocusNodeEmail,
                        controller: signupEmailController,

                        keyboardType: TextInputType.phone,
                        onChanged: bloc.changeSignUpPhone,

                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          errorText: MadarLocalizations.of(context)
                              .trans(phoneSnapshot.error),
                          errorStyle: TextStyle(height: 0.1),
                          border: InputBorder.none,
                          icon: isoCodePicker(),
                        ),
                      ),
                    );
                  }));
        });
  }

  Widget passwordTextField() {
    return StreamBuilder<bool>(
      stream: bloc.obscureSignUpPasswordStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: TextField(
            focusNode: myFocusNodePassword,
            controller: signupPasswordController,
            obscureText: snapshot.data ?? true,

            onChanged: bloc.changeSignUpPassword,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 16.0,
                color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                FontAwesomeIcons.lock,
                color: Colors.black,
              ),
              hintText: MadarLocalizations.of(context).trans('password'),
              hintStyle:
                  TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
              suffixIcon: GestureDetector(
                onTap: () => bloc.pushObscureSignUpPassword,
                child: Icon(
                  FontAwesomeIcons.eye,
                  size: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget isoCodePicker() {
    return CountryCodePicker(
      favorite: ['SA', 'TR', 'KW', 'AE'],
      initialSelection: widget.code,
      onChanged: bloc.changeSignUpIsoCode,
    );
  }

  Widget signUpBtn() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: StreamBuilder<bool>(
        stream: bloc.submitValidSignUp,
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
                    } else
                      bloc.submitSignUp();
                  },
                  width: 150,
                  height: 50,
                  loading: (snapshot.data == null ? false : snapshot.data) &&
                      loadingSnapshot.data,
                );
              });
        },
      ),
    );
  }
}
