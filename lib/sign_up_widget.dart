import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/user.dart';

class SignUpWidget extends StatefulWidget {
  @override
  SignUpWidgetState createState() {
    return new SignUpWidgetState();
  }
}

class SignUpWidgetState extends State<SignUpWidget> with UserFeedback {
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
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: bloc.submitSignUpStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInSnackBar(
                snapshot.error.toString(), context);
          });
        }
        if (snapshot.hasData) {
          appBloc.saveUser(snapshot.data.user);
          appBloc.saveToken(snapshot.data.token);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => HomePage()));
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
                      height: 360.0,
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
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          isoCodePicker(),
                        ],
                      ),
                    ),
                  ),
                  signUpBtn(),
                ],
              ),
            ],
          ),
        );
      }
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
          hintText: "Name",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeEmail,
        controller: signupEmailController,
        keyboardType: TextInputType.phone,
        onChanged: bloc.changeSignUpPhone,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.mobile,
            color: Colors.black,
          ),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
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
              hintText: "Password",
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
    return Padding(
        padding:
        EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
        child: CountryCodePicker(
          favorite: ['SY', 'TR'],
          initialSelection: 'SY',
          onChanged: bloc.changeSignUpIsoCode,
        )
    );
  }


  Widget signUpBtn() {
    return Container(
      margin: EdgeInsets.only(top: 120),
      child: StreamBuilder<bool>(
        stream: bloc.submitValidSignUp,
        initialData: false,
        builder: (context, snapshot) {
          return MainButton(
            text: 'Submit',
            onPressed: () {
              if (!snapshot.hasData || !snapshot.data) {
                showInSnackBar('Please provide valid information', context);
              } else
                bloc.submitSignUp();
            },
            width: 150,
            height: 50,
            loading: snapshot.data,
          );
        },
      ),
    );
  }
}
