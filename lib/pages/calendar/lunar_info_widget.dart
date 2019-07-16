import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/ui/show_up.dart';

class LunarInfoWidget extends StatelessWidget {

  final DateTime dateTimeSelected;

  LunarInfoWidget({this.dateTimeSelected});

  @override
  Widget build(BuildContext context) {
    Lunar lunar = CalendarUtils.solarToLunarByDateTime(dateTimeSelected);
    String canChiDay = CalendarUtils.getCanChiOfDay(dateTimeSelected.day, dateTimeSelected.month, dateTimeSelected.year);
    String canChiMonth = CalendarUtils.getCanChiOfMonth(lunar.lunarYear, lunar.lunarMonth);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Ngày", style: TextStyle(fontSize: 16.0),),
                    ShowUp(
                      child: Text("${lunar.lunarDay}",
                          style: TextStyle(
                              color: lunar.lunarDay ==
                                  15 ||
                                  lunar.lunarDay == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.blueAccent,
                              fontSize: 100.0,
                              fontWeight: FontWeight.bold)),
                      delay: 500,
                    ),
                    Text(canChiDay,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Tháng", style: TextStyle(fontSize: 16.0),),
                    Text("${lunar.lunarMonth}",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 100.0,
                            fontWeight: FontWeight.bold)),
                    Text(canChiMonth,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
