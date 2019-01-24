import 'package:flutter/material.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/animated_header.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/final_step.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:madar_booking/trip_planning/step_choose_date_page.dart';
import 'package:madar_booking/trip_planning/step_choose_sub_city.dart';
import 'package:madar_booking/trip_planning/step_chosse_car.dart';
import 'package:madar_booking/trip_planning/step_trip_type.dart';
import 'package:madar_booking/feedback.dart';

class TripPlanningPage extends StatefulWidget {
  @override
  TripPlanningPageState createState() {
    return new TripPlanningPageState();
  }
}

class TripPlanningPageState extends State<TripPlanningPage> with UserFeedback {
  final steps = [
    ChooseCityStep(),
    TripTypeStep(),
    StepChooseDatePage(),
    StepChooseCar(),
    StepChooseSubCity(),
    FinalStep(),
  ];

  TripPlaningBloc bloc;

  @override
  void initState() {
    bloc = TripPlaningBloc(BlocProvider.of<AppBloc>(context).token,
        BlocProvider.of<AppBloc>(context).userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: WillPopScope(
        onWillPop: () {
          if (bloc.index == 0) {
            Navigator.of(context).pop();
          } else
            bloc.navBackward;
        },
        child: StreamBuilder<bool>(
            stream: bloc.loadingStream,
            initialData: false,
            builder: (context, loadingSnapshot) {
              return Scaffold(
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
                        // Hero(
                        //   tag: "header_container",
                        //   child: AnimatedHeader(
                        //     isAnimate: true,
                        //   ),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: MadarColors.gradiant_decoration),
                          child: StreamBuilder<int>(
                              stream: bloc.navigationStream,
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    appBar: AppBar(
                                      iconTheme:
                                          IconThemeData(color: Colors.black87),
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
                                    body: steps[snapshot.data]);
                              }),
                        ),
                      ],
                    );
                  },
                ),
                floatingActionButton: StreamBuilder<String>(
                  stream: bloc.changeTextStream,
                  initialData: 'next',
                  builder: (context, snapshot) {
                    return MainButton(
                      width: 150,
                      height: 50,
                      text: MadarLocalizations.of(context).trans(snapshot.data),
                      loading: loadingSnapshot.data,
                      onPressed: () {
                        if (bloc.index == 5) {
                          Navigator.of(context).pop();
                        } else if (bloc.done) {
                          bloc.submitTrip();
                        } else
                          bloc.navForward;
                      },
                    );
                  },
                ),
              );
            }),
      ),
    );
  }

  title(i) {
    if (i == 0) {
      return MadarLocalizations.of(context).trans('choose_city');
    } else if (i == 1) {
      return MadarLocalizations.of(context).trans('choose_type');
    } else if (i == 2) {
      return MadarLocalizations.of(context).trans('choose_date');
    } else if (i == 3) {
      return MadarLocalizations.of(context).trans('choose_car');
    } else if (i == 4) {
      return MadarLocalizations.of(context).trans('extend_your_trip');
    } else {
      return '';
    }
  }
}
