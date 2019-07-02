import 'package:flutter_test/flutter_test.dart';
import 'package:pageview/utils/calendar.dart';

void main() {

  group("Test get Can Chi Of Year", () {
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
  });
  
  group("Test Get Truc Kien Not Lead Year", () {
    test("Get List Truc Kien In Month 1", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 1, 1));
      expect(a, [10, 11, 0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3]);
    });
    test("Get List Truc Kien In Month 2", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 2, 10));
      expect(a, [4, 5, 6, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6]);
    });
    test("Get List Truc Kien In Month 3", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 3, 20));
      expect(a, [7, 8, 9, 10, 11, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0]);
    });
    test("Get List Truc Kien In Month 4", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 4, 30));
      expect(a, [1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5]);
    });
    test("Get List Truc Kien In Month 5", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 5, 1));
      expect(a, [6, 7, 8, 9, 10, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
    });
    test("Get List Truc Kien In Month 6", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 6, 5));
      expect(a, [0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4]);
    });
    test("Get List Truc Kien In Month 7", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 7, 2));
      expect(a, [5, 6, 7, 8, 9, 10, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    });
    test("Get List Truc Kien In Month 8", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 8, 2));
      expect(a, [11, 0, 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4]);
    });
    test("Get List Truc Kien In Month 9", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 9, 2));
      expect(a, [5, 6, 7, 8, 9, 10, 11, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });
    test("Get List Truc Kien In Month 10", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 10, 2));
      expect(a, [10, 11, 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3]);
    });
    test("Get List Truc Kien In Month 11", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 11, 2));
      expect(a, [4, 5, 6, 7, 8, 9, 10, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });
    test("Get List Truc Kien In Month 12", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2019, 12, 2));
      expect(a, [9, 10, 11, 0, 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2]);
    });
  });

  group("Test Get Truc Kien In Month With Lead Year", () {
    test("Get List Truc Kien In Month 1", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 1, 1));
      expect(a, [3, 4, 5, 6, 7, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });
    test("Get List Truc Kien In Month 2", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 2, 1));
      expect(a, [9, 10, 11, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0]);
    });
    test("Get List Truc Kien In Month 3", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 3, 1));
      expect(a, [1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6]);
    });
    test("Get List Truc Kien In Month 4", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 4, 1));
      expect(a, [7, 8, 9, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
    });
    test("Get List Truc Kien In Month 5", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 5, 1));
      expect(a, [0, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5]);
    });
    test("Get List Truc Kien In Month 6", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 6, 1));
      expect(a, [6, 7, 8, 9, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    });
    test("Get List Truc Kien In Month 7", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 7, 1));
      expect(a, [11, 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4]);
    });
    test("Get List Truc Kien In Month 8", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 8, 1));
      expect(a, [5, 6, 7, 8, 9, 10, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    });
    test("Get List Truc Kien In Month 9", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 9, 1));
      expect(a, [11, 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3]);
    });
    test("Get List Truc Kien In Month 10", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 10, 1));
      expect(a, [4, 5, 6, 7, 8, 9, 10, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });
    test("Get List Truc Kien In Month 11", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 11, 1));
      expect(a, [10, 11, 0, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2]);
    });
    test("Get List Truc Kien In Month 12", () {
      List a = CalendarUtils.getListTrucKienInMonth(DateTime(2020, 12, 1));
      expect(a, [3, 4, 5, 6, 7, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });
  });
}