import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';

import '../MainButton.dart';
import '../bloc_provider.dart';
import 'PdfPeview.dart';
import 'bloc/trip_planing_bloc.dart';

class FinalStep extends StatefulWidget {
  @override
  _FinalStepState createState() => _FinalStepState();
}

class _FinalStepState extends State<FinalStep> {
  TripPlaningBloc planingBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planingBloc = BlocProvider.of<TripPlaningBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
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

            StreamBuilder<bool>(
                stream: planingBloc.gettingPdfStream,
                initialData: false,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  print("77777777777777777");
                  if (snapshot.data) {
                    return CircularProgressIndicator();
                  } else {
                    return MainButton(
                      margainTop: 0,
                      text: MadarLocalizations.of(context).trans('view_trip'),
                      onPressed: () {
                        planingBloc.f_createPDF(planingBloc.trip.tripId, (val) {
                          print("kmkjljknkkj");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PdfPreview(val)));
                        });
                      },
                      width: 150,
                      height: 50,
                    );
                  }
                }),
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
