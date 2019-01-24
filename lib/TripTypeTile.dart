import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/madarLocalizer.dart';

class TripTypeTile extends StatefulWidget {
  final IconData iconData;
  final String title;
  final Function(bool) onChecked;
  final bool checked;

  const TripTypeTile(
      {Key key,
      this.iconData,
      this.title,
      this.onChecked,
      this.checked = false})
      : super(key: key);

  @override
  TripTypeTileState createState() {
    return new TripTypeTileState();
  }
}

class TripTypeTileState extends State<TripTypeTile> {
  bool _checked;

  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.yellow[700],
          onTap: () {
            setState(() {
              _checked = !_checked;
              widget.onChecked(_checked);
            });
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: <Widget>[
                _checked
                    ? Align(
                        alignment: MadarLocalizations.of(context).locale.languageCode == 'en' ? Alignment.topRight : Alignment.topLeft,
                        child: Icon(
                          FontAwesomeIcons.solidCheckCircle,
                          color: Colors.yellow[700],
                        ),
                      )
                    : Container(),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(widget.iconData),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
