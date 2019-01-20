import 'package:flutter/material.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/madar_fonts.dart';
import 'package:madar_booking/models/TripModel.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  TripCard(this.trip);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("helllo");
      },
      child: Padding(
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
          width: 185,
          height: 185,
          child: Container(
            width: 185,
            height: 185,
            decoration: BoxDecoration(
              gradient:
                  MadarColors.gradiantFromColors(trip.color1, trip.color2),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          trip.titleEn,
                          style: TextStyle(
                              fontSize: AppFonts.large_font_size,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: '${trip.duration}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppFonts.x_large_font_size,
                                        fontWeight: FontWeight.bold)),
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
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Days",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                AppFonts.x_small_font_size,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          trip.descriptionEn,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.medium_font_size),
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
      ),
    );
  }
}
