import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/facebook_bloc.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/user.dart';
import 'feedback.dart';
import 'package:country_code_picker/country_code_picker.dart';


class Step2SignUp extends StatefulWidget {
  @override
  Step2SignUpState createState() => new Step2SignUpState();

  final String socialId;
  final String socialToken;
  final String userName;

  const Step2SignUp({Key key, this.socialId, this.socialToken, this.userName})
      : assert(socialId != null),
        assert(socialToken != null),
        assert(userName != null),
        super(key: key);
}

class Step2SignUpState extends State<Step2SignUp> with UserFeedback {
  final FocusNode phoneFocusNode = FocusNode();
  TextEditingController phoneController = new TextEditingController();
  FacebookBloc bloc;

  @override
  void initState() {
    bloc = FacebookBloc(widget.socialId, widget.socialToken, widget.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: bloc.userStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          BlocProvider.of<AppBloc>(context).saveUser(snapshot.data);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }

        if(snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInSnackBar(snapshot.error.toString(), context);
          });
        }
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
                  Center(
                    child: Text('One last thing. Please fill you phone number and country', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600
                    ),),
                  ),
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
                                        isoCodePicker(),
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


  Widget isoCodePicker() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: CountryCodePicker(
        favorite: ['SY', 'TR'],
        onChanged: bloc.changeIsoCode,
      )
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
              showInSnackBar(
                  'Provide a valid phone number or password', context);
            } else
              bloc.submit();
          },
          width: 150,
          height: 50,
          loading: snapshot.data,
        );
      },
    );
  }
}
