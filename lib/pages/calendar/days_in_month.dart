import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/theme.dart';

class DaysInMonth extends StatefulWidget {

  static BuildContext context;

  final List<DateItem> items;

  final int selectedDay;

  DaysInMonth({Key key, this.items, this.selectedDay}) :  super(key: key);

  @override
  _DaysInMonthState createState() => _DaysInMonthState();
}

class _DaysInMonthState extends State<DaysInMonth> {
  PageController _pageController;

  @override
  initState(){
    _pageController = new PageController(initialPage: widget.selectedDay - 1, viewportFraction: 0.30);
    super.initState();
  }

  Widget _buildDayItem(BuildContext context, int position) {
    DateItem item = widget.items[position];
    int solarDay = item.solarDateTime.day;
    int weekDay = item.solarDateTime.weekday;
    
    Color itemTextColor = solarDay == widget.selectedDay ? Colors.white :
                          (weekDay == 6 || weekDay == 7) ? primaryColor : secondaryColor;
    return Container(
      //width: 90.0,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      child: GestureDetector(
        onTap: () {
          print("$solarDay");
        },
        child: Card(
          elevation: 3,
          color: solarDay == widget.selectedDay ? primaryColor : bgDayItem,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(solarDay.toString(), style: TextStyle(
                  color: itemTextColor,
                  fontSize: Theme.of(context).textTheme.display1.fontSize,
                  fontWeight: FontWeight.bold,
                ),),
                Text(CalendarUtils.getDayStringBy(weekDay), style: TextStyle(
                  color: itemTextColor,
                  fontSize: Theme.of(context).textTheme.subtitle.fontSize,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: false,
      controller: _pageController,
      itemBuilder: _buildDayItem,
      itemCount: widget.items.length,
    );
  }
}
