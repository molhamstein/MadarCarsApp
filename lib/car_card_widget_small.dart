import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/Car.dart';
import 'package:madar_booking/rate_widget.dart';
import 'madar_fonts.dart';

class CarCardSmall extends StatelessWidget {
  final Car car;
  final Function(Car) onTap;
  final bool selected;

  CarCardSmall({@required this.car, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.3;
    final height = MediaQuery.of(context).size.height / 5;
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [MadarColors.shadow],
                  color: Colors.white,
                ),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(car.media.thumb),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black38, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 4, top: 4),
                                    child: RateWidget('${car.rate}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 4, top: 4),
                                    child: Text(
                                      car.brand.name(
                                          MadarLocalizations.of(context)
                                              .locale),
                                      style: AppTextStyle.smallTextStyleWhite,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 4, top: 4),
                                    child: Text(car.driver.firstName,
                                        style:
                                            AppTextStyle.smallTextStyleWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, bottom: 8, top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: '${car.pricePerDay}',
                                      style: AppTextStyle.largeTextStyleWhite,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '\$',
                                      style: AppTextStyle.smallTextStyleWhite,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "/${MadarLocalizations.of(context).trans("day")}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 0.5))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              border: Border.all(
                                  color: Colors.yellow[700], width: 1),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: Colors.yellow[700],
                              size: 24,
                            )),
                      ),
                    )
                  : Container(),

              Align(
                alignment: Alignment.topLeft,
                child: car.isVip ? Container(
                  width: width,
                  height: height,
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/vip.png',
                    width: 50,
                    height: 50,
                  ),
                ) : Container(),
              ),
            ],
          )),
    );
  }
}
