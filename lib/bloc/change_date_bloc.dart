import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/utils/calendar.dart';

class ChangeDateBloc extends ChangeNotifier {
  DateTime _dateTime = new DateTime.now();

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime inputDateTime) {
    _dateTime = inputDateTime;
    notifyListeners();
  }

  String getCanChiYear() {
    Lunar lunar = solarToLunar();
    return CalendarUtils.getCanChiOfYear(lunar.lunarYear);
  }

  Lunar solarToLunar() {
    Solar solar = Solar(solarYear: _dateTime.year, solarMonth: _dateTime.month, solarDay: _dateTime.day);
    return LunarSolarConverter.solarToLunar(solar);
  }
}