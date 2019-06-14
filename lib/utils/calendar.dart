class CalendarUtils {
  static List<String> cans = [
    "Giáp",
    "Ất",
    "Bính",
    "Đinh",
    "Mậu",
    "Kỷ",
    "Canh",
    "Tân",
    "Nhâm",
    "Quí"
  ];
  static List<String> chis = [
    "Tý",
    "Sửu",
    "Dần",
    "Mão",
    "Thìn",
    "Tỵ",
    "Ngọ",
    "Mùi",
    "Thân",
    "Dậu",
    "Tuất",
    "Hợi"
  ];

  // Get day of vietnamese from week day
  static String getDayStringBy(int index) {
    switch (index) {
      case 1:
        return "Thứ hai";
      case 2:
        return "Thứ ba";
      case 3:
        return "Thứ tư";
      case 4:
        return "Thứ năm";
      case 5:
        return "Thứ sáu";
      case 6:
        return "Thứ bảy";
      case 7:
        return "Chủ nhật";
    }
    return '';
  }

  static String getCanChiOfYear(int lunarYear) {
    int can = (lunarYear + 6) % 10;
    int chi = (lunarYear + 8) % 12;
    return cans[can] + " " + chis[chi];
  }

  static String getCanChiOfMonth(int lunarYear, int lunarMonth) {
    int can = (lunarYear * 12 + lunarMonth + 3) % 10;
    int chi = (lunarMonth + 1) % 12;
    return cans[can] + " " + chis[chi];
  }

  static String getCanChiOfDay(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();

    int can = (jd + 9) % 10;
    int chi = (jd + 1) % 12;
    return cans[can] + " " + chis[chi];
  }

  static String getCanChiOfHour(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();
    int can = (jd - 1) * 2 % 10;
    return cans[can] + " " + chis[0];
  }

  static int getJDFromDate(int solarDay, int solarMonth, int solarYear) {
    var a = ((14 - solarMonth) / 12).floor();
    var y = solarYear + 4800 - a;
    var m = solarMonth + 12 * a - 3;
    var jd = solarDay +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;
    if (jd < 2299161) {
      jd = solarDay + ((153 * m + 2) / 5).floor() + 365 * y + (y / 4).floor() - 32083;
    }
    return jd.toInt();
  }
}
