import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';

class SignUpWidget extends StatefulWidget {


  @override
  SignUpWidgetState createState() {
    return new SignUpWidgetState();
  }
}

class SignUpWidgetState extends State<SignUpWidget> {
  final FocusNode myFocusNodePassword = FocusNode();

  final FocusNode myFocusNodeEmail = FocusNode();

  final FocusNode myFocusNodeName = FocusNode();

  final TextEditingController signupEmailController = new TextEditingController();

  final TextEditingController signupNameController = new TextEditingController();

  final TextEditingController signupPasswordController = new TextEditingController();

  final TextEditingController signupConfirmPasswordController = new TextEditingController();

  AuthBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      emailTextField(),
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
                      passwordConfirmationTextField(),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.redAccent[100],
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Colors.indigoAccent[200],
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [Colors.redAccent[100], Colors.indigoAccent[200]],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.redAccent[100],

                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
//                  onPressed: () => showInSnackBar("SignUp button pressed"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding: EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeName,
        controller: signupNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
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
          hintStyle: TextStyle(
              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeEmail,
        controller: signupEmailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.envelope,
            color: Colors.black,
          ),
          hintText: "Email Address",
          hintStyle: TextStyle(
              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }


  Widget passwordTextField() {
    return StreamBuilder<bool>(
      stream: bloc.obscureSignUpPasswordStream,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: TextField(
            focusNode: myFocusNodePassword,
            controller: signupPasswordController,
            obscureText: snapshot.data ?? true,
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
              hintStyle: TextStyle(
                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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


  Widget passwordConfirmationTextField() {
    return StreamBuilder<bool>(
      stream: bloc.obscureSignUpPasswordConfirmationStream,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: TextField(
            controller: signupConfirmPasswordController,
            obscureText: snapshot.data ?? true,
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
              hintText: "Confirmation",
              hintStyle: TextStyle(
                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
              suffixIcon: GestureDetector(
                onTap: () => bloc.pushObscureSignUpPasswordConfirmation,
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
}