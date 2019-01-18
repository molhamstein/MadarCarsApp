import 'package:flutter/material.dart';
import 'package:madar_booking/widgets/sub_city_tile.dart';

class StepChooseSubCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 24, left: 24),
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 16, left: 16, top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0),
                      child: Text(
                        'Estim Cost',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '250',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 60,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '\$',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 32),
                  child: Text('You can also extend your trip to the following cities.', style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.w600),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: <Widget>[
                        SubCityTile(onCounterChanged: (c){},),
                        SubCityTile(onCounterChanged: (c){},),
                        SubCityTile(onCounterChanged: (c){},),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
