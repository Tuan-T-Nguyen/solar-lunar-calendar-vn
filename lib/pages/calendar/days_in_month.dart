import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/theme.dart';

class DaysInMonth extends StatelessWidget {

  static BuildContext context;

  final List<DateInfo> items;

  DaysInMonth(this.items);

  Widget _buildDayItem(BuildContext context, int position) {
    DateInfo item = items[position];
    Color itemTextColor = (item.now.weekday == 6 || item.now.weekday == 7) ? primaryColor : secondaryColor;
    return Container(
      width: 80.0,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(item.now.day.toString(), style: TextStyle(
              color: item.now.weekday == 6 || item.now.weekday == 7 ? primaryColor : secondaryColor,
              fontSize: 40.0,
            ),),
            Text(CalendarUtils.getDayStringBy(item.now.weekday)),
          ],
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
