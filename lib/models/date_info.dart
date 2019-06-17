import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class DateInfo {
  // Solar Info
  DateTime now;
  int solarDay;
  String solarWeekDay;
  // Lunar Info
  Lunar lunar;
  String lunarYear;
  int lunarDay;
  String lunarCanChiDay;
  int lunarMonth;
  String lunarCanChiMonth;

  DateInfo({this.now,});

}
