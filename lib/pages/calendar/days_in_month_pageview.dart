import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/theme.dart';
import 'package:provider/provider.dart';

class DaysInMonthPageView extends StatefulWidget {

  static BuildContext context;

  final DateTime dateTimeSelected;

  DaysInMonthPageView({Key key, this.dateTimeSelected}) :  super(key: key);

  @override
  _DaysInMonthPageViewState createState() => _DaysInMonthPageViewState();
}

class _DaysInMonthPageViewState extends State<DaysInMonthPageView> {

  PageController _pageController;
  DateTime mDateTimeSelected;

  @override
  initState(){
    _pageController = new PageController(initialPage: widget.dateTimeSelected.day - 1, viewportFraction: 0.3);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Future<List<DateItem>> _getDaysInMonth(DateTime dateTime) async {
    List<DateItem> daysInMonth = [];
    var lastDayDateTime = dateTime.month < 12
        ? new DateTime(dateTime.year, dateTime.month + 1, 0)
        : new DateTime(dateTime.year + 1, 1, 0);
    for (int i = 1; i <= lastDayDateTime.day; i++) {
      daysInMonth.add(new DateItem(new DateTime(dateTime.year, dateTime.month, i)));
    }
    return daysInMonth;
  }

  Widget createPageView(BuildContext context, AsyncSnapshot snapshot) {
    List<DateItem> items = snapshot.data;
    return new PageView.builder(
      controller: _pageController,
      pageSnapping: false,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int position) {
        DateItem item = items[position];
        int solarDay = item.solarDateTime.day;
        int weekDay = item.solarDateTime.weekday;

        Color itemTextColor = solarDay == widget.dateTimeSelected.day ? Colors.white :
        (weekDay == 6 || weekDay == 7) ? primaryColor : secondaryColor;
        return Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          child: GestureDetector(
            onTap: () {
              if (mDateTimeSelected == null || mDateTimeSelected.day != item.solarDateTime.day) {
                Provider.of<DateModel>(context, listen: false).setNow(item.solarDateTime);
                mDateTimeSelected = item.solarDateTime;
              }
            },
            child: Card(
              elevation: 3,
              color: solarDay == widget.dateTimeSelected.day ? primaryColor : bgDayItem,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
      future: _getDaysInMonth(widget.dateTimeSelected),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
          // Default is done
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createPageView(context, snapshot);
        }
      },
    );

    return futureBuilder;
  }
}
