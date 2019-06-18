import 'package:flutter/foundation.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/utils/calendar.dart';

class DateModel extends ChangeNotifier {
  DateTime _now = new DateTime.now();

  getNow() => _now;

  setNow(DateTime now) {
    _now = now;
    notifyListeners();
  }

//  String getCanChiYear() {
//    Lunar lunar = solarToLunar();
//    return CalendarUtils.getCanChiOfYear(lunar.lunarYear);
//  }
//
//  String getCanChiMonth() {
//    Lunar lunar = solarToLunar();
//    return CalendarUtils.getCanChiOfMonth(lunar.lunarYear, lunar.lunarMonth);
//  }
//
//  String getCanChiDay() {
//    return CalendarUtils.getCanChiOfDay(now.day, now.month, now.year);
//  }
//
//  // Get Lunar date from now
//  Lunar solarToLunar() {
//    Solar solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
//    return LunarSolarConverter.solarToLunar(solar);
//  }
}
//
//
@immutable
class DateItem {
  final DateTime solarDateTime;
  //final int solarYear;

  DateItem(this.solarDateTime);

}