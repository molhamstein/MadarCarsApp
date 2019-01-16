import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/location.dart';

class CityRadioTile extends StatelessWidget {
  final bool selected;
  final Function(Location) onTap;
  final Location location;

  const CityRadioTile({Key key, this.selected, this.onTap, this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileSize = MediaQuery.of(context).size.width / 2.5;

    return Container(
      margin: EdgeInsets.all(8),
      height: tileSize,
      width: tileSize,
      decoration: BoxDecoration(
        gradient: MadarColors.gradiant_decoration,
        image: DecorationImage(
          image: AssetImage('assets/images/bursa.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.4), BlendMode.dstATop),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap(location);
          },
          splashColor: Colors.yellow[200],
          child: Stack(
            children: <Widget>[
              Container(
                width: tileSize,
                height: tileSize,
                padding: EdgeInsets.only(top: 16, right: 4),
                child: Align(
                  alignment: Alignment.topRight,
                  child: selected
                      ? Icon(
                          FontAwesomeIcons.solidCheckCircle,
                          color: Colors.yellow[700],
                          size: 24,
                        )
                      : Container(),
                ),
              ),
              Container(
                width: tileSize,
                height: tileSize,
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    location.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
