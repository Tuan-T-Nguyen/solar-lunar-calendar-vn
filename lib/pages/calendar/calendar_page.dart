import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageview/models/date_info.dart';
import 'package:provider/provider.dart';

import '../../data-bg.dart';
import 'days_in_month.dart';
import 'illustration_day.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<DateItem> _daysInMonth = [];

  @override
  void initState() {
    _daysInMonth = setDaysInMonth(new DateTime.now());
    super.initState();
  }

  List<DateItem> setDaysInMonth(DateTime _now) {
    List<DateItem> daysInMonth = [];
    var lastDayDateTime = _now.month < 12
        ? new DateTime(_now.year, _now.month + 1, 0)
        : new DateTime(_now.year + 1, 1, 0);
    for (int i = 1; i <= lastDayDateTime.day; i++) {
      daysInMonth.add(new DateItem(new DateTime(_now.year, _now.month, i)));
    }
    return daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => DateModel(),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            // Days
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: 130.0,
              child: DaysInMonth(
                items: _daysInMonth,
                selectedDay: 12,
              ),
            ),

            // Illustrations
           IllustrationDay(),


            // Lunar Info
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            'Năm ' + _selectedDateInfo.getCanChiYear(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Ngày"),
                                Text("${_selectedDateInfo.solarToLunar().lunarDay}",
                                    style: TextStyle(
                                        color: _selectedDateInfo.solarToLunar().lunarDay == 15 ||
                                            _selectedDateInfo.solarToLunar().lunarDay == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.blueAccent,
                                        fontSize: 100.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    _selectedDateInfo.getCanChiDay(),
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Tháng"),
                                Text("${_selectedDateInfo.solarToLunar().lunarMonth}",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 100.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    _selectedDateInfo.getCanChiMonth(),
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

