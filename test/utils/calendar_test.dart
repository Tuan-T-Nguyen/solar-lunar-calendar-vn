import 'package:flutter_test/flutter_test.dart';
import 'package:pageview/utils/calendar.dart';

void main() {

  test('Get Can Chi Of Min Year', () {
    String canChi = CalendarUtils.getCanChiOfYear(1930);
    expect(canChi, "Canh Ngọ");
  });
  test('Get Can Chi Of Max Year', () {
    String canChi = CalendarUtils.getCanChiOfYear(2100);
    expect(canChi, "Canh Thân");
  });
  test('Get Can Chi Of 1990', () {
    String canChi = CalendarUtils.getCanChiOfYear(1990);
    expect(canChi, "Canh Ngọ");
  });
  test('Get Can Chi Of 1991', () {
    String canChi = CalendarUtils.getCanChiOfYear(1991);
    expect(canChi, "Tân Mùi");
  });
  test('Get Can Chi Of 2019', () {
    String canChi = CalendarUtils.getCanChiOfYear(2019);
    expect(canChi, "Kỷ Hợi");
  });
  test('Get Can Chi Of 2020', () {
    String canChi = CalendarUtils.getCanChiOfYear(2020);
    expect(canChi, "Canh Tý");
  });



}