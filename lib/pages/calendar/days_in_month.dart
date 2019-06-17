import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/theme.dart';

class DaysInMonth extends StatelessWidget {

  static BuildContext context;

  final List<DateInfo> items;

  int selectedDay;

  DaysInMonth(this.items, this.selectedDay);

  Widget _buildDayItem(BuildContext context, int position) {
    DateInfo item = items[position];
    Color itemTextColor = item.now.day == selectedDay ? Colors.white :
                          (item.now.weekday == 6 || item.now.weekday == 7) ? primaryColor : secondaryColor;
    return Container(
      width: 90.0,
      child: Card(
        color: item.now.day == selectedDay ? primaryColor : bgDayItem,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(item.now.day.toString(), style: TextStyle(
                color: itemTextColor,
                fontSize: Theme.of(context).textTheme.display1.fontSize,
                fontWeight: FontWeight.bold,
              ),),
              Text(CalendarUtils.getDayStringBy(item.now.weekday), style: TextStyle(
                color: itemTextColor,
                fontSize: Theme.of(context).textTheme.subtitle.fontSize,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: _buildDayItem,
      itemCount: items.length,
    );
  }
}
