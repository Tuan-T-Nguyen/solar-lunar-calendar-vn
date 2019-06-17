import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/theme.dart';

class DaysInMonth extends StatefulWidget {

  static BuildContext context;

  final List<DateInfo> items;

  final int selectedDay;

 // DaysInMonth(this.items, this._selectedDay);

  DaysInMonth({Key key, this.items, this.selectedDay}) :  super(key: key);

  @override
  _DaysInMonthState createState() => _DaysInMonthState();
}

class _DaysInMonthState extends State<DaysInMonth> {
  PageController _pageController;

  @override
  initState(){
    _pageController = new PageController(initialPage: widget.selectedDay - 1, viewportFraction: 0.2);
    super.initState();
  }

  Widget _buildDayItem(BuildContext context, int position) {
    DateInfo item = widget.items[position];
    Color itemTextColor = item.now.day == widget.selectedDay ? Colors.white :
                          (item.now.weekday == 6 || item.now.weekday == 7) ? primaryColor : secondaryColor;
    return Container(
      width: 90.0,
      child: Card(
        color: item.now.day == widget.selectedDay ? primaryColor : bgDayItem,
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
    return PageView.builder(
      controller: _pageController,
      itemBuilder: _buildDayItem,
      itemCount: widget.items.length,
    );
  }
}
