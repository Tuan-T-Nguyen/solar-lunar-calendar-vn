import 'package:flutter/widgets.dart';
import 'package:pageview/utils/calendar.dart';

class HHDao {
  final String chi;
  final String durationHour;

  HHDao({@required this.chi, @required this.durationHour});

  String getZodiacImage(bool isLargeSize) {
    return CalendarUtils.getIconZodiacImage(this.chi, isLargeSize);
  }

  int getStartTime() {
    return CalendarUtils.getTimeByChi(chi, true);
  }

  int getEndTime() {
    return CalendarUtils.getTimeByChi(chi, false);
  }
}