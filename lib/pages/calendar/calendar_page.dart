import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageview/models/date_info.dart';
import 'package:provider/provider.dart';

import '../../data-bg.dart';
import 'days_in_month.dart';

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
   // return ChangeNotifierProvider(
   //   builder: (context) => DateModel(),
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            // Days
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: 130.0,
              child: Consumer<DateModel>(
                builder: (context, dateModel, child) {
                  return DaysInMonth(
                    items: _daysInMonth,
                    selectedDay: dateModel.getNow().day,
                  );
                },
              ),
            ),

            // Illustrations
            new IllustrationDay(),

            // Lunar Info
            new LunarInfo(),
          ],
        ),
      );
   // );
  }
}

class IllustrationDay extends StatelessWidget {
  const IllustrationDay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(3.0, 3.0),
                    color: Colors.grey,
                    blurRadius: 4.0),
              ],
            ),
            height: 80.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  assetsSvgBackground[3],
                  height: 120.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0, right: 4.0),
                    height: 80.0,
                    alignment: Alignment.center,
                    child: Text(
                      "Ngày quốc tế ông già, đàn ông, con trai, bé trai.",
                      style: TextStyle(
                        color: Colors.white,
                        //  fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LunarInfo extends StatelessWidget {
  const LunarInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateModel>(
      builder: (context, dateModel, child) {
        return Expanded(
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
                        'Năm ' + dateModel.getCanChiYear(),
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
                            Text("${dateModel.solarToLunar().lunarDay}",
                                style: TextStyle(
                                    color: dateModel.solarToLunar().lunarDay ==
                                                15 ||
                                            dateModel.solarToLunar().lunarDay ==
                                                1
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueAccent,
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold)),
                            Text(dateModel.getCanChiDay(),
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
                            Text("${dateModel.solarToLunar().lunarMonth}",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold)),
                            Text(dateModel.getCanChiMonth(),
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
        );
      },
    );
  }
}
