import 'package:flutter/material.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/utils/size_config.dart';

import 'bottom_sheet_lunar_widget.dart';
import 'days_in_month_widget.dart';
import 'illustration_day_widget.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
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
                  height: height_days_in_month,
                  child: DaysInMonthWidget(),
                ),
                // Illustrations
                Flexible(flex: 2, child: IllustrationDayWidget()),
                //SizedBox(height: size_20,)
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
