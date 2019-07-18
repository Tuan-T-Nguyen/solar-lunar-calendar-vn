import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/database/json/models/xuathanh.dart';
import 'package:pageview/database/json/models/xuathanh_list.dart';
import 'package:pageview/utils/calendar.dart';

class XuathanhRepository {
  static Future<String> _loadAssets() async {
    return await rootBundle.loadString('assets/data/xuathanh.json');
  }

  static Future<XuatHanhList> getXuatHanhs() async {
    String jsonString = await _loadAssets();
    final jsonRes = json.decode(jsonString);
    return XuatHanhList.fromJson(jsonRes);
  }

  static Future<XuatHanh> getXuatHanh(DateTime dateTime) async {
    XuatHanhList xuatHanhList = await getXuatHanhs();
    for (XuatHanh xuatHanh in xuatHanhList.xuathanhs) {
      if (xuatHanh.surplus == CalendarUtils.getSurplus(dateTime)) {
        return xuatHanh;
      }
    }
    return null;
  }
}