import 'package:flutter/foundation.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/utils/calendar.dart';

class DateModel extends ChangeNotifier {
  DateTime _now = new DateTime.now();

  DateTime getNow() => _now;

  setNow(DateTime now) {
    _now = now;
    notifyListeners();
  }

  String getCanChiYear() {
    Lunar lunar = solarToLunar();
    return CalendarUtils.getCanChiOfYear(lunar.lunarYear);
  }

  String getCanChiMonth() {
    Lunar lunar = solarToLunar();
    return CalendarUtils.getCanChiOfMonth(lunar.lunarYear, lunar.lunarMonth);
  }

  String getCanChiDay() {
    return CalendarUtils.getCanChiOfDay(_now.day, _now.month, _now.year);
  }

  Lunar solarToLunar() {
    Solar solar = Solar(solarYear: _now.year, solarMonth: _now.month, solarDay: _now.day);
    return LunarSolarConverter.solarToLunar(solar);
  }

  String getHoursOfHoangDao() {
    List<String> hourList = CalendarUtils.getHourOfHoangDao(_now);
    String result = "";
    for(String hoangdao in hourList) {
      result += hoangdao + ", ";
    }
    result = result.trim();
    if (result.endsWith(",")) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }
}

@immutable
class DateItem {
  final DateTime solarDateTime;

  DateItem({@required this.solarDateTime});
}