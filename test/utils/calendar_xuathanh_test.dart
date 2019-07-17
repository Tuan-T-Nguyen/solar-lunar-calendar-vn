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
  });
}