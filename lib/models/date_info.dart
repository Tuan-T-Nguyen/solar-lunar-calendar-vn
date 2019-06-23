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
}

@immutable
class DateItem {
  final DateTime solarDateTime;

  DateItem(this.solarDateTime);

}