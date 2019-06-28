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
  static const String TY = "Tý";
  static const String SUU = "Sửu";
  static const String DAN = "Dần";
  static const String MAO = "Mão";
  static const String THIN = "Thìn";
  static const String TI = "Tị";
  static const String NGO = "Ngọ";
  static const String MUI = "Mùi";
  static const String THAN = "Thân";
  static const String DAU = "Dậu";
  static const String TUAT = "Tuất";
  static const String HOI = "Hợi";
  static List<String> chis = [
    TY, SUU, DAN, MAO, THIN, TI, NGO, MUI, THAN, DAU, TUAT, HOI
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

  static String getChiOfDay(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();
    int chi = (jd + 1) % 12;
    return chis[chi];
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

  // http://azone.vn/ngay-hoang-dao-ngay-hac-dao-gio-hoang-dao-gio-hac-dao-la-gi-d68825
  static List<String> getHourOfHoangDao(DateTime solarDateTime) {
    String chiOfDay = getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
    List<String> result = new List<String>();
    switch (chiOfDay) {
      case DAN:
      case THAN:
        result.add(TY); result.add(SUU); result.add(THIN); result.add(TI); result.add(MUI); result.add(TUAT);
        break;
      case MAO:
      case DAU:
        result.add(TY); result.add(DAN); result.add(MAO); result.add(NGO); result.add(MUI); result.add(DAU);
        break;
      case THIN:
      case TUAT:
        result.add(DAN); result.add(THIN); result.add(TI); result.add(THAN); result.add(DAU); result.add(HOI);
        break;
      case TI:
      case HOI:
        result.add(SUU); result.add(THIN); result.add(NGO); result.add(MUI); result.add(TUAT); result.add(HOI);
        break;
      case TY:
      case NGO:
        result.add(TY); result.add(SUU); result.add(MAO); result.add(NGO); result.add(THAN); result.add(DAU);
        break;
      case SUU:
      case MUI:
        result.add(DAN); result.add(MAO); result.add(TI); result.add(THAN); result.add(TUAT); result.add(HOI);
        break;
      default:
        return [];
    }
    return result;
  }

  static List<String> getHourOfHacDao(DateTime solarDateTime) {
    String chiOfDay = getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
    List<String> result;
    switch (chiOfDay) {
      case DAN:
      case THAN:
        result = [DAN, MAO, NGO, THAN, DAU, HOI];
        //result.add(DAN); result.add(MAO); result.add(NGO); result.add(THAN); result.add(DAU); result.add(HOI);
        break;
      case MAO:
      case DAU:
        result = [SUU, THIN, TI, THAN, TUAT, HOI];
        //result.add(SUU); result.add(THIN); result.add(TI); result.add(THAN); result.add(TUAT); result.add(HOI);
        break;
      case THIN:
      case TUAT:
        result = [TY, SUU, MAO, NGO, MUI, TUAT];
        //result.add(TY); result.add(SUU); result.add(MAO); result.add(NGO); result.add(MUI); result.add(TUAT);
        break;
      case TI:
      case HOI:
        result = [TY, DAN, MAO, TI, THAN, DAU];
        //result.add(TY); result.add(DAN); result.add(MAO); result.add(TI); result.add(THAN); result.add(DAU);
        break;
      case TY:
      case NGO:
        result = [DAN, THIN, TI, MUI, TUAT, HOI];
        //result.add(DAN); result.add(THIN); result.add(TI); result.add(MUI); result.add(TUAT); result.add(HOI);
        break;
      case SUU:
      case MUI:
        result = [TY, SUU, THIN, NGO, MUI, DAU];
        //result.add(TY); result.add(SUU); result.add(THIN); result.add(NGO); result.add(MUI); result.add(DAU);
        break;
      default:
        return [];
    }
    return result;
  }
}
