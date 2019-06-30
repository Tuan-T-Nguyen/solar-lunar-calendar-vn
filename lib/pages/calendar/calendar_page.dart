import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet_lunar_widget.dart';
import 'days_in_month_widget.dart';
import 'illustration_day_widget.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  String _timeString;

  @override
  void initState() {
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
    super.initState();
  }

  void _getCurrentTime()  {
    setState(() {
      _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.6,
          child: Container(
            child: Column(
              children: <Widget>[
                // Days
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: height_days_in_month,
                  child: Consumer<DateModel>(
                    builder: (context, dateModel, child) {
                      return DaysInMonthWidget(
                        dateTimeSelected: dateModel.getNow(),
                      );
                    },
                  ),
                ),

                // Illustrations
                IllustrationDayWidget(),
                Text(_timeString),
              ],
            ),
          ),
        ),
        BottomSheetLunarWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return getWidget();
  }
}

