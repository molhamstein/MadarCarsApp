import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/home_page.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/UserResponse.dart';
import 'package:madar_booking/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileWidget extends StatefulWidget {
  @override
  EditProfileWidgetState createState() {
    return new EditProfileWidgetState();
  }
}

class EditProfileWidgetState extends State<EditProfileWidget>
    with UserFeedback {
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

  final _imageController = BehaviorSubject<ImageProvider>();
  Function(ImageProvider) get insertuserImage => _imageController.sink.add;
  Stream<ImageProvider> get userImageStream => _imageController.stream;

  File _image;

  String lastSelectedValue;
  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      insertuserImage(FileImage(_image));
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

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
              showInSnackBar(snapshot.error.toString(), context);
            });
          }
          if (snapshot.hasData) {
            appBloc.saveUser(snapshot.data.user);
            appBloc.saveToken(snapshot.data.token);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => HomePage()));
            });
          }
          return Container(
            // color: Colors.red,
            child: Container(
              padding: EdgeInsets.only(top: 23.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 60.0),
                        height: 330.0,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [MadarColors.shadow],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Container(
                        // RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(8.0),
                        // ),
                        child: Column(
                          children: <Widget>[
                            profileImage(),
                            Container(
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
                                  // passwordTextField(),
                                  // Container(
                                  //   width: 250.0,
                                  //   height: 1.0,
                                  //   color: Colors.grey[400],
                                  // ),
                                  isoCodePicker(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: signUpBtn(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
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

  Widget profileImage() {
    return StreamBuilder<ImageProvider>(
        stream: userImageStream,
        initialData: AssetImage('assets/images/profileImg.png'),
        builder: (context, snapshoot) {
          if (snapshoot.hasData) {
            InkWell(
              onTap: () {
                print("pressed");
                showDemoActionSheet(
                  context: context,
                  child: CupertinoActionSheet(
                      title: const Text('Choose Source'),
                      message: const Text(
                          'Please select the From where you want to choose image'),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Container(child: Text('Camera')),
                          onPressed: () {
                            getImageFromCamera();
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Container(child: Text('Gallery')),
                          onPressed: () {
                            getImageFromGallery();
                          },
                        )
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        isDefaultAction: false,
                        onPressed: () {
                          // Navigator.pop(context, 'Cancel');
                        },
                      )),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  boxShadow: [MadarColors.shadow],
                  border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(
                    image: snapshoot.data,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return Image(
              image: AssetImage('assets/image/progileImg.png'),
            );
          }
        });
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
          onChanged: bloc.changeSignUpIsoCode,
        ));
  }

  Widget signUpBtn() {
    return Container(
      margin: EdgeInsets.only(top: 120),
      child: StreamBuilder<bool>(
        stream: bloc.submitValidSignUp,
        initialData: false,
        builder: (context, snapshot) {
          return MainButton(
            text: 'Update',
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
