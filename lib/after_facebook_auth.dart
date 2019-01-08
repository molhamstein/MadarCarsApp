import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/facebook_bloc.dart';
import 'package:madar_booking/madar_colors.dart';
import 'feedback.dart';

class AfterFacebookAuth extends StatefulWidget {
  @override
  AfterFacebookAuthState createState() => new AfterFacebookAuthState();
}

class AfterFacebookAuthState extends State<AfterFacebookAuth> with UserFeedback{
  final FocusNode phoneFocusNode = FocusNode();
  TextEditingController phoneController = new TextEditingController();
  FacebookBloc bloc;

  @override
  void initState() {
    bloc = FacebookBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [MadarColors.gradientUp, MadarColors.gradientDown],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 75.0),
                child: Container(
                  width: 250.0,
                  height: 191.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Expanded(
                flex: 2,
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Container(
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
                                    isoCodeTextField(),
                                  ],
                                ),
                              ),
                            ),
                            submitBtn(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
      stream: bloc.phoneStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: Container(
            height: 60,
            child: TextField(
              focusNode: phoneFocusNode,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: bloc.changePhone,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                errorText: snapshot.error,
                icon: Icon(
                  FontAwesomeIcons.mobile,
                  color: Colors.black,
                  size: 22.0,
                ),
                hintText: "Phone Number",
                hintStyle:
                    TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget isoCodeTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        onChanged: bloc.changeIsoCode,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black,
          ),
          hintText: "ISO Code",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget submitBtn() {
    return StreamBuilder<bool>(
      stream: bloc.submitValid,
      initialData: false,
      builder: (context, snapshot) {
        return MainButton(
          text: 'Submit',
          onPressed: () {
            if (!snapshot.data) {
              showInSnackBar('Provide a valid phone number or password', context);
            } else bloc.submit();
          },
          width: 150,
          height: 50,
          loading: snapshot.data,
        );
      },
    );
  }
}
