import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';

import '../bloc_provider.dart';
import '../madar_colors.dart';
import 'bloc/trip_planing_bloc.dart';


class FinalStep extends StatefulWidget {
  @override
  _FinalStepState createState() => _FinalStepState();
}

class _FinalStepState extends State<FinalStep> {

TripPlaningBloc planingBloc ;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
    print("////////////");
print(planingBloc.trip.tripId);
}

  @override
  Widget build(BuildContext context) {
    print("////////////");
    print(planingBloc.trip.tripId);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                MadarLocalizations.of(context)
                    .trans('trip_created_successfully'),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/success_icon.png',
                height: 100,
                width: 100,
              ),
            ),


            InkWell(
              onTap: (){
                
                planingBloc.f_createPDF(planingBloc.trip.tripId);
              },
              child: AnimatedContainer(
                curve: Curves.ease,
                margin: EdgeInsets.only(left: 16, right: 16),
                duration: Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: MadarColors.gradientDown,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: MadarColors.gradientUp,
                    ),
                  ],
                ),
//                  width: width,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8,left: 16,right: 16),
                  child: Text(
                    //Todo done
                    "Open summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

//            Padding(
//              padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
//              child: Text(MadarLocalizations.of(context).trans('prices_may_vary'), style: TextStyle(
//                color: Colors.grey[300], fontSize: 12,
//              ),),
//            )
          ],
        ),
      ),
    );
  }
}
