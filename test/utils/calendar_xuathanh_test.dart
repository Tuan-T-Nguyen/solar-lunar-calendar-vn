import 'package:flutter_test/flutter_test.dart';
import 'package:pageview/utils/calendar.dart';

void main() {
  group("Test get Khac", () {
    test("Get Khac 1", () {
      int khac1_1 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 11, 0));
      expect(khac1_1, 1);

      int khac1_2 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 12, 59));
      expect(khac1_2, 1);

      int khac1_3 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 11, 11));
      expect(khac1_3, 1);

      int khac1_4 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 13, 0));
      expect(khac1_4, 2);
    });

    test("Get Khac 4 - 1", () {
      int khac4_1 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 5, 0));
      expect(khac4_1, 4);

      int khac4_2 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 6, 0));
      expect(khac4_2, 4);

      int khac4_3 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 6, 59));
      expect(khac4_3, 4);

      int khac4_4 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 7, 0));
      expect(khac4_4, 5);
    });

    test("Get Khac 4 - 2", () {
      int khac4_1 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 17, 0));
      expect(khac4_1, 4);

      int khac4_2 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 18, 0));
      expect(khac4_2, 4);

      int khac4_3 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 18, 59));
      expect(khac4_3, 4);

      int khac4_4 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 19, 0));
      expect(khac4_4, 5);
    });

    test("Get Khac 6 - 1", () {
      int khac6_1 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 9, 0));
      expect(khac6_1, 6);

      int khac6_2 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 10, 0));
      expect(khac6_2, 6);

      int khac6_3 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 10, 59));
      expect(khac6_3, 6);

      int khac6_4 = CalendarUtils.getKhacOfTime(new DateTime(2019, 1, 1, 11, 0));
      expect(khac6_4, 1);
    });
  });
  
  group("Test surplus", () {
    // (lunar day + lunar month + khac - 2) % 6
    test("Get Surplus Khac 1", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 11));
      expect(3, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 23));
      expect(3, surplus2);
    });

    test("Get Surlus Khac 2", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 1));
      expect(4, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 13));
      expect(4, surplus2);
    });

    test("Get Surlus Khac 3", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 3));
      expect(5, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 15));
      expect(5, surplus2);
    });

    test("Get Surlus Khac 4", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 5));
      expect(0, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 17));
      expect(0, surplus2);
    });

    test("Get Surlus Khac 5", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 7));
      expect(1, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 19));
      expect(1, surplus2);
    });

    test("Get Surlus Khac 6", () {
      int surplus1 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 9));
      expect(2, surplus1);

      int surplus2 = CalendarUtils.getSurplus(new DateTime(2019, 7, 18, 21));
      expect(2, surplus2);
    });
  });
}