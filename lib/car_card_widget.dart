import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/rate_widget.dart';
import 'madar_fonts.dart';
import "package:intl/date_symbol_data_file.dart";

class CarCard extends StatelessWidget {
  final Car car;
  CarCard(this.car);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("helllo");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 320,
          // height: 225.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [MadarColors.shadow],
            // color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  // image container
                  // height: 175.0,
                  child: Container(
                    decoration: BoxDecoration(
                      // boxShadow: [MadarColors.shadow],
                      image: DecorationImage(
                          image: NetworkImage(car.media.thumb),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 24.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () {
                            print("helllp");
                          },
                          textColor: Colors.white,
                          child: Text(
                            car.location.nameEn,
                            style: TextStyle(
                              fontSize: AppFonts.small_font_size,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color.fromARGB(255, 36, 36, 36),
                        ),
                      ),
                    ),
                    alignment: Alignment(-1.0, 1.0),
                  ),
                ),
              ),
              // info container
              Expanded(
                flex: 1,
                child: Container(
                  // height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    car.name,
                                    style: TextStyle(
                                        fontSize: AppFonts.small_font_size,
                                        fontWeight: FontWeight.bold,
                                        height: 1.25),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      DateFormat.y().format(
                                          DateTime.parse(car.productionDate)),
                                      style: TextStyle(
                                          fontSize: AppFonts.small_font_size,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RateWidget(
                                  '${car.rate}',
                                  50,
                                  20,
                                ),
                                Text(car.driver.firstName,
                                    style: TextStyle(
                                        fontSize: AppFonts.small_font_size,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: '${car.pricePerDay}',
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontSize: AppFonts.large_font_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '\$',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("/day",
                                    style: TextStyle(
                                        fontSize: AppFonts.small_font_size,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade600))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
