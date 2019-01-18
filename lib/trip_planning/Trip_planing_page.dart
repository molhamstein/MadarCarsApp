import 'package:flutter/material.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:madar_booking/trip_planning/step_choose_date_page.dart';
import 'package:madar_booking/trip_planning/step_choose_sub_city.dart';
import 'package:madar_booking/trip_planning/step_chosse_car.dart';
import 'package:madar_booking/trip_planning/step_trip_type.dart';

class TripPlanningPage extends StatefulWidget {

  @override
  TripPlanningPageState createState() {
    return new TripPlanningPageState();
  }
}

class TripPlanningPageState extends State<TripPlanningPage> {
  final steps = [
    ChooseCityStep(),
    TripTypeStep(),
    StepChooseDatePage(),
    StepChooseCar(),
    StepChooseSubCity(),
  ];

  int index;

  Widget _currentStep;
  TripPlaningBloc bloc;

  @override
  void initState() {
    index = 0;
    bloc = TripPlaningBloc();
    _currentStep = steps.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: MadarColors.gradiant_decoration
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.black87),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text('Choose City', style: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w700),),
                ),
                body: _currentStep,
              )
            ),

            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 40),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MainButton(
                  width: 150,
                  height: 50,
                  text: 'Next',
                  onPressed: () {
                    setState(() {
                      index++;
                      _currentStep = steps[index];
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}