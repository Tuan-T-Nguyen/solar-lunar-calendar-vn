import 'package:pageview/database/json/models/xuathanh.dart';

class XuatHanhList {
  final List<XuatHanh> xuathanhs;

  XuatHanhList({this.xuathanhs});

  factory XuatHanhList.fromJson(List<dynamic> json) {
    List<XuatHanh> xuathanhs = new List<XuatHanh>();
    xuathanhs = json.map((i) => XuatHanh.fromJson(i)).toList();

    return new XuatHanhList(
      xuathanhs: xuathanhs
    );
  }
}