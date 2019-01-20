import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/rate_widget.dart';
import 'madar_fonts.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final Function(Car) onTap;
  final bool selected;

  CarCard({@required this.car, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width / 1.3;

    return InkWell(
        onTap: () {
          onTap(car);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
            Container(
            width: width,
            // height: 225.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [MadarColors.shadow],
              color: Colors.white,
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
                          boxShadow: [MadarColors.shadow],
                          image: DecorationImage(
                              image: NetworkImage(car.media.thumb),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5.0)),
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
                                        car.productionDate.toString(),
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
                                    rate: '${car.rate}',
                                    width: 50,
                                    height: 20,
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
                                              fontSize: AppFonts
                                                  .large_font_size,
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
          selected
              ? Container(
            padding: EdgeInsets.all(16),
            width: width,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow[700], width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black38,
                        )
                      ]
                  ),
                  child: Icon(
                    FontAwesomeIcons.solidCheckCircle,
                    color: Colors.yellow[700],
                    size: 24,
                  )
              ),
            ),
          ) : Container(),
          ],
        )
    ),);
  }
}
