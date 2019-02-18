import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/madar_fonts.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'app_text_style.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  TripCard(this.trip);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [MadarColors.shadow],
          color: Colors.transparent,
          image: DecorationImage(
            image: NetworkImage(trip.media.thumb),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.height / 3.8,
        height: MediaQuery.of(context).size.height / 3.8,
        child: Container(
          width: MediaQuery.of(context).size.height / 3.8,
          height: MediaQuery.of(context).size.height / 3.8,
          decoration: BoxDecoration(
            gradient: MadarColors.gradiantFromColors(trip.color1, trip.color2),
            color: Color.fromARGB(180, 255, 255, 255),
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: AutoSizeText(
                        trip.title(MadarLocalizations.of(context).locale),
                        maxLines: 1,
                        style: AppTextStyle.largeTextStyleWhite,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: '${trip.duration}',
                                    style: AppTextStyle.xLaragTextStyleWhite),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 30,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: MadarLocalizations.of(context)
                                            .trans("days"),
                                        style:
                                            AppTextStyle.xSmallTextStyleWhite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      // width: 150,
                      child: Text(
                        trip.description(MadarLocalizations.of(context).locale),
                        style: AppTextStyle.meduimTextStyleWhite,
                        // softWrap: true,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
