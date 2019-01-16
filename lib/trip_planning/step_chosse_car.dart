import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/widgets/language_tag.dart';

class StepChooseCar extends StatelessWidget {
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
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '220',
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
                Padding(padding: EdgeInsets.all(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Ford Mustang', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                        Text('Mahmout Orhan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[600]),),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16),
                      label: Text('4.5'),
                      avatar: Icon(FontAwesomeIcons.solidStar, color: Colors.yellow[700], size: 18,),
                    ),
                  ],
                ),

                Container(height: 15,),

                Wrap(
                  spacing: 4,
                  children: <Widget>[
                    LanguageTag(text: Text('Arabic', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),),
                    LanguageTag(text: Text('English', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),),
                    LanguageTag(text: Text('Turkish', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),),
                  ],
                ),

                Container(height: 30,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.calendar, size: 24,),
                          Text('2013'),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.transgender),
                            Text('Female Driver'),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.chair),
                          Text('6 Seats'),
                        ],
                      ),
                    ],
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
