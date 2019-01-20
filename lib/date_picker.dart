import 'package:flutter/material.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final double size;
  final DateTime date;
  final Function(DateTime) onDateChanged;
  final bool withTimePicker;
  final String title;

  const DatePicker(
      {Key key,
      this.size = 50,
      @required this.onDateChanged,
      this.withTimePicker = false,
      this.title = 'Date', this.date})
      : super(key: key);

  @override
  DatePickerState createState() {
    return new DatePickerState();
  }
}

class DatePickerState extends State<DatePicker> {
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  @override
  void initState() {
    _selectedDate = widget.date == null ? DateTime.now() : widget.date;
    _selectedTime = widget.date == null ? TimeOfDay(hour: 0, minute: 0) : TimeOfDay(hour: widget.date.hour, minute: widget.date.minute);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
              fontSize: widget.size * 0.42,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        Padding(
          padding: EdgeInsets.all(4),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _selectDate,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _selectedDate.day.toString(),
                  style: TextStyle(
                      fontSize: widget.size,
                      fontWeight: FontWeight.w700,
                      color: MadarColors.dark_grey),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      DateFormat.MMM().format(_selectedDate),
                      style: TextStyle(
                          fontSize: widget.size * 0.53,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[600]),
                    ),
                    Text(
                      DateFormat.y().format(_selectedDate),
                      style: TextStyle(
                          fontSize: widget.size * 0.34,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        widget.withTimePicker ? Text(
         'At ' + DateFormat('hh:mm a').format(DateTime(0,0,0, _selectedTime.hour, _selectedTime.minute)),
          style: TextStyle(
              fontSize: widget.size * 0.34,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500]),
        ) : Container(height: widget.size * 0.34,),
      ],
    );
  }

  _selectDate() async {
    bool timeChanged = false;
    bool dateChanged = false;
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (date != null && date != _selectedDate) dateChanged = true;

    TimeOfDay time;
    if (widget.withTimePicker)
      time = await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null && time != _selectedTime) timeChanged = true;

    if (dateChanged || timeChanged) {

      DateTime selectedDate = DateTime(date.year, date.month, date.day, 23);
      if(dateChanged && timeChanged) {
        selectedDate = DateTime(date.year, date.month, date.day, time.hour);
      }

      setState(() {
        _selectedDate = date;
        widget.onDateChanged(selectedDate);
        _selectedTime = time;
      });
    }
  }
}
