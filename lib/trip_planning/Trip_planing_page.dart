import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madar_booking/CreditCardFormField.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/main.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/final_step.dart';
import 'package:madar_booking/trip_planning/need_help_page.dart';
import 'package:madar_booking/trip_planning/step_airport.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:madar_booking/trip_planning/step_choose_date_page.dart';
import 'package:madar_booking/trip_planning/step_chosse_car.dart';
import 'package:madar_booking/trip_planning/step_trip_type.dart';
import 'package:madar_booking/ui/DayByDayPage.dart';
import 'package:madar_booking/ui/Step_summary.dart';

class TripPlanningPage extends StatefulWidget {
  final TripModel tripModel;

  const TripPlanningPage({Key key, this.tripModel}) : super(key: key);

  @override
  TripPlanningPageState createState() {
    return new TripPlanningPageState();
  }
}

class TripPlanningPageState extends State<TripPlanningPage> with UserFeedback {
  TripPlaningBloc bloc;
  TextEditingController _noteController;
  var cityStep = ChooseCityStep();
  var typeStep = TripTypeStep();

  TextEditingController _dateController = new TextEditingController();
  TextEditingController _cardNumController = new TextEditingController();
  TextEditingController _cardNameController = new TextEditingController();
  TextEditingController _securityCodeController = new TextEditingController();

  getStep(Steps step) {
    switch (step) {
      case Steps.chooseCity:
        return cityStep;
      case Steps.chooseType:
        return typeStep;
      case Steps.chooseAirports:
        return AirportStep();
      case Steps.chooseDate:
        return StepChooseDatePage();
      case Steps.chooseCar:
        return StepChooseCar();
      case Steps.chooseSuplocations:
        return DayByDayPage();
      case Steps.summary:
        return StepSummary();
      case Steps.finalstep:
        return FinalStep();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    print('in VIEW = ' + widget.tripModel.toString());
    _noteController = TextEditingController();
    bloc = TripPlaningBloc(
      BlocProvider.of<AppBloc>(context).token,
      BlocProvider.of<AppBloc>(context).userId,
      tripModel: widget.tripModel,
    );
    print('token is = ' + BlocProvider.of<AppBloc>(context).token);
    bloc.getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: WillPopScope(
        onWillPop: () async {
          if (bloc.step == Steps.chooseCity || bloc.step == Steps.finalstep) {
            Navigator.of(context).pop();
            return false;
          } else {
            bloc.navBackward;
            return false;
          }
        },
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.transparent,
            body: Builder(builder: (scaffoldContext) {
              return StreamBuilder<bool>(
                  stream: bloc.loadingStream,
                  initialData: false,
                  builder: (context, loadingSnapshot) {
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      body: StreamBuilder<String>(
                        stream: bloc.feedbackStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError && bloc.showFeedback) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showInSnackBar(snapshot.error, context,
                                  color: Colors.redAccent);
                              bloc.showFeedback = false;
                            });
                          }
                          if (snapshot.hasData && bloc.showFeedback) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showInSnackBar(snapshot.data, context);
                              bloc.showFeedback = false;
                            });
                          }
                          return Stack(
                            children: <Widget>[
                              Hero(
                                tag: "header_container",
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient:
                                          MadarColors.gradiant_decoration),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                // decoration: BoxDecoration(
                                //     gradient: MadarColors.gradiant_decoration),
                                child: StreamBuilder<Steps>(
                                    stream: bloc.navigationStream,
                                    initialData: Steps.chooseCity,
                                    builder: (context, snapshot) {
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        appBar: AppBar(
                                          iconTheme: IconThemeData(
                                              color: Colors.black87),
                                          backgroundColor: Colors.transparent,
                                          centerTitle: true,
                                          elevation: 0,
                                          title: Text(
                                            title(snapshot.data),
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        body: getStep(snapshot.data),
                                      );
                                    }),
                              ),
                              StreamBuilder<bool>(
                                  stream: bloc.helpStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData && snapshot.data)
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NeedHelpPage()));
                                      });
                                    return Container();
                                  }),
                            ],
                          );
                        },
                      ),
                      floatingActionButton: StreamBuilder<String>(
                        stream: bloc.changeTextStream,
                        initialData: 'next',
                        builder: (context, snapshot) {
                          return StreamBuilder<bool>(
                              stream: bloc.noteButtonStream,
                              builder: (context, noteSnapshot) {
                                return Hero(
                                  tag: 'tripButton',
                                  child: MainButton(
                                      width: isScreenLongEnough ? 150 : 120,
                                      height: isScreenLongEnough ? 50 : 40,
                                      miniButton: noteSnapshot.hasData &&
                                          noteSnapshot.data,
                                      text: MadarLocalizations.of(context)
                                          .trans(snapshot.data),
                                      loading: loadingSnapshot.data,
                                      onPressed: () {
                                        if (bloc.step == Steps.finalstep) {
                                          Navigator.of(context).pop();
                                        } else if (bloc.done) {
//                                          showModalBottomSheet(
//                                            context: context,
//                                            builder: (context) {
//                                              return Container(
//                                                padding:
//                                                    EdgeInsets.only(top: 16),
//                                                color: Colors.white,
//                                                width: MediaQuery.of(context)
//                                                    .size
//                                                    .width,
//                                                child: Padding(
//                                                  padding:
//                                                      const EdgeInsets.only(
//                                                          bottom: 20.0),
//                                                  child: Column(
//                                                    mainAxisSize:
//                                                        MainAxisSize.min,
//                                                    children: <Widget>[
//                                                      Row(
//                                                        children: <Widget>[
//                                                          Container(
//                                                            width:
//                                                                MediaQuery.of(
//                                                                        context)
//                                                                    .size
//                                                                    .width,
//                                                            child: Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .only(
//                                                                      left: 8.0,
//                                                                      right: 8),
//                                                              child: TextField(
//                                                                keyboardType:
//                                                                    TextInputType
//                                                                        .number,
//                                                                controller:
//                                                                    _cardNumController,
//                                                                decoration:
//                                                                    InputDecoration(
//                                                                  contentPadding:
//                                                                      const EdgeInsets
//                                                                              .all(
//                                                                          10.0),
//                                                                  hasFloatingPlaceholder:
//                                                                      true,
//                                                                  hintText: MadarLocalizations.of(
//                                                                          context)
//                                                                      .trans(
//                                                                          "Card_Number"),
//                                                                  border:
//                                                                      OutlineInputBorder(),
//                                                                ),
//                                                              ),
//                                                            ),
//                                                          ),
//                                                        ],
//                                                      ),
//                                                      Padding(
//                                                        padding:
//                                                            EdgeInsets.only(
//                                                                top: 16,
//                                                                bottom: 16),
//                                                        child: Row(
//                                                          children: <Widget>[
//                                                            Container(
//                                                              width:
//                                                                  MediaQuery.of(
//                                                                          context)
//                                                                      .size
//                                                                      .width,
//                                                              child: Padding(
//                                                                padding:
//                                                                    const EdgeInsets
//                                                                            .only(
//                                                                        left:
//                                                                            8.0,
//                                                                        right:
//                                                                            8),
//                                                                child:
//                                                                    TextField(
//                                                                  controller:
//                                                                      _cardNameController,
////
//
//                                                                  decoration:
//                                                                      InputDecoration(
//                                                                    contentPadding:
//                                                                        const EdgeInsets.all(
//                                                                            10.0),
//                                                                    hasFloatingPlaceholder:
//                                                                        true,
//                                                                    hintText: MadarLocalizations.of(
//                                                                            context)
//                                                                        .trans(
//                                                                            "Name_of_card"),
//                                                                    border:
//                                                                        OutlineInputBorder(),
//                                                                  ),
//                                                                ),
//                                                              ),
//                                                            ),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                      Row(
//                                                        children: <Widget>[
////
//
//                                                          Container(
//                                                            width: MediaQuery.of(
//                                                                        context)
//                                                                    .size
//                                                                    .width /
//                                                                2,
//                                                            child: Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .only(
//                                                                      left: 8.0,
//                                                                      right: 8),
//                                                              child:
//                                                                  ExpirationFormField(
//                                                                controller:
//                                                                    _dateController,
//                                                                decoration:
//                                                                    InputDecoration(
//                                                                  contentPadding:
//                                                                      const EdgeInsets
//                                                                              .all(
//                                                                          10.0),
//                                                                  hasFloatingPlaceholder:
//                                                                      true,
////                                                                        labelText: "Card Expiration",
//                                                                  hintText:
//                                                                      "MM/YY",
//                                                                  border:
//                                                                      OutlineInputBorder(),
//                                                                ),
//                                                              ),
//                                                            ),
//                                                          ),
//
////
//
//                                                          Container(
//                                                            width: MediaQuery.of(
//                                                                        context)
//                                                                    .size
//                                                                    .width /
//                                                                2,
//                                                            child: Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .only(
//                                                                      left: 8.0,
//                                                                      right: 8),
//                                                              child:
//                                                                  CVVFormField(
//                                                                inputFormatters: [
//                                                                  LengthLimitingTextInputFormatter(
//                                                                      4),
//                                                                ],
//                                                                decoration:
//                                                                    InputDecoration(
//                                                                  hintText:
//                                                                      "CVV",
//                                                                  contentPadding:
//                                                                      const EdgeInsets
//                                                                              .all(
//                                                                          10.0),
//                                                                  border:
//                                                                      OutlineInputBorder(),
//                                                                ),
//                                                                controller:
//                                                                    _securityCodeController,
//                                                              ),
//                                                            ),
//                                                          ),
//
////
//                                                        ],
//                                                      ),
//                                                      Padding(
//                                                        padding:
//                                                            const EdgeInsets
//                                                                    .only(
//                                                                top: 16.0),
//                                                        child: Row(
//                                                          mainAxisAlignment:
//                                                              MainAxisAlignment
//                                                                  .spaceEvenly,
//                                                          children: <Widget>[
//                                                            Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .only(
//                                                                      left:
//                                                                          20.0,
//                                                                      right:
//                                                                          20),
//                                                              child:
//                                                                  RaisedButton(
//                                                                shape: RoundedRectangleBorder(
//                                                                    borderRadius:
//                                                                        BorderRadius.circular(
//                                                                            25)),
//                                                                onPressed: () {
//                                                                  Navigator.pop(
//                                                                      context);
//                                                                },
//                                                                child: new Text(
//                                                                    "Cancle",
//                                                                    style: TextStyle(
//                                                                        color: Colors
//                                                                            .white,
//                                                                        fontSize:
//                                                                            16,
//                                                                        height:
//                                                                            0.5)),
//                                                                color: MadarColors
//                                                                    .dark_grey,
//                                                              ),
//                                                            ),
//                                                            Padding(
//                                                              padding:
//                                                                  const EdgeInsets
//                                                                          .only(
//                                                                      left:
//                                                                          20.0,
//                                                                      right:
//                                                                          20),
//                                                              child:
//                                                                  RaisedButton(
//                                                                shape: RoundedRectangleBorder(
//                                                                    borderRadius:
//                                                                        BorderRadius.circular(
//                                                                            25)),
//                                                                onPressed: () {
//                                                                  Navigator.pop(
//                                                                      context);
//                                                                },
//                                                                child: new Text(
//                                                                    "Check",
//                                                                    style: TextStyle(
//                                                                        color: Colors
//                                                                            .white,
//                                                                        fontSize:
//                                                                            16,
//                                                                        height:
//                                                                            0.5)),
//                                                                color: MadarColors
//                                                                    .gradientDown,
//                                                              ),
//                                                            ),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              );
//                                            },
//                                          );


                                          bloc.submitTrip()
;
                                        } else
                                          bloc.navForward;
                                      },
                                      onMiniBtnPressed: () =>
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: EdgeInsets.all(16),
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: TextField(
                                                      controller:
                                                          _noteController,
                                                      onSubmitted: (s) {
                                                        bloc.trip.note = s;
                                                        Navigator.pop(context);
                                                      },
                                                      autofocus: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hasFloatingPlaceholder:
                                                            true,
                                                        hintText:
                                                            MadarLocalizations
                                                                    .of(context)
                                                                .trans(
                                                                    'your_note'),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),

//                                          bloc.submitTrip()

                                  ),
                                );
                              });
                        },
                      ),
                    );
                  });
            })),
      ),
    );
  }

  title(Steps step) {
    switch (step) {
      case Steps.chooseCity:
        return MadarLocalizations.of(context).trans('choose_city');
      case Steps.chooseType:
        return MadarLocalizations.of(context).trans('choose_type');
      case Steps.chooseAirports:
        return MadarLocalizations.of(context).trans('choose_AirPort');
      case Steps.chooseDate:
        return MadarLocalizations.of(context).trans('choose_date');
      case Steps.chooseCar:
        return MadarLocalizations.of(context).trans('choose_car');
      case Steps.chooseSuplocations:
        return MadarLocalizations.of(context).trans('extend_your_trip');
      case Steps.summary:
        return MadarLocalizations.of(context).trans('Summary');
      default:
        return "";
    }
  }
}
