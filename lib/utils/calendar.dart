import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/models/hh_dao.dart';
import "dart:math";

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
  static List<String> CHIS = [
    TY,
    SUU,
    DAN,
    MAO,
    THIN,
    TI,
    NGO,
    MUI,
    THAN,
    DAU,
    TUAT,
    HOI
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
    return cans[can] + " " + CHIS[chi];
  }

  static String getCanChiOfMonth(int lunarYear, int lunarMonth) {
    int can = (lunarYear * 12 + lunarMonth + 3) % 10;
    int chi = (lunarMonth + 1) % 12;
    return cans[can] + " " + CHIS[chi];
  }

  static String getCanChiOfDay(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();

    int can = (jd + 9) % 10;
    int chi = (jd + 1) % 12;
    return cans[can] + " " + CHIS[chi];
  }

  static String getChiOfDay(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();
    int chi = (jd + 1) % 12;
    return CHIS[chi];
  }

  static String getCanChiOfHour(int solarDay, int solarMonth, int solarYear) {
    int jd = getJDFromDate(solarDay, solarMonth, solarYear).toInt();
    int can = (jd - 1) * 2 % 10;
    return cans[can] + " " + CHIS[0];
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
      jd = solarDay +
          ((153 * m + 2) / 5).floor() +
          365 * y +
          (y / 4).floor() -
          32083;
    }
    return jd.toInt();
  }

  static String getDurationHourByChi(String chi) {
    switch (chi) {
      case TY:
        return "23 - 1 giờ";
      case SUU:
        return "1 - 3 giờ";
      case DAN:
        return "3 - 5 giờ";
      case MAO:
        return "5 - 7 giờ";
      case THIN:
        return "7 - 9 giờ";
      case TI:
        return "9 - 11 giờ";
      case NGO:
        return "11 - 13 giờ";
      case MUI:
        return "13 - 15 giờ";
      case THAN:
        return "15 - 17 giờ";
      case DAU:
        return "17 - 19 giờ";
      case TUAT:
        return "19 - 21 giờ";
      case HOI:
        return "21 - 23 giờ";
      default:
        return "";
    }
  }

  static String getIconZodiacImage(String chi, bool isLargeSize) {
    switch (chi) {
      case TY:
        return isLargeSize ? "assets/12Zodiac/ty.jpeg" : "assets/12Zodiac/mouse.jpeg";
      case SUU:
        return isLargeSize ? "assets/12Zodiac/suu.jpeg" : "assets/12Zodiac/buffalo.jpeg";
      case DAN:
        return isLargeSize ? "assets/12Zodiac/dan.jpeg" : "assets/12Zodiac/tiger.jpeg";
      case MAO:
        return isLargeSize ? "assets/12Zodiac/mao.jpeg" : "assets/12Zodiac/cat.jpeg";
      case THIN:
        return isLargeSize ? "assets/12Zodiac/thin.jpeg" : "assets/12Zodiac/dragon.jpeg";
      case TI:
        return isLargeSize ? "assets/12Zodiac/ti.jpeg" : "assets/12Zodiac/snake.jpeg";
      case NGO:
        return isLargeSize ? "assets/12Zodiac/ngo.jpeg" : "assets/12Zodiac/horse.jpeg";
      case MUI:
        return isLargeSize ? "assets/12Zodiac/mui.jpeg" : "assets/12Zodiac/goat.jpeg";
      case THAN:
        return isLargeSize ? "assets/12Zodiac/than.jpeg" : "assets/12Zodiac/monkey.jpeg";
      case DAU:
        return isLargeSize ? "assets/12Zodiac/dau.jpeg" : "assets/12Zodiac/chicken.jpeg";
      case TUAT:
        return isLargeSize ? "assets/12Zodiac/tuat.jpeg" : "assets/12Zodiac/dog.jpeg";
      case HOI:
        return isLargeSize ? "assets/12Zodiac/hoi.jpeg" : "assets/12Zodiac/pig.jpeg";
      default:
        return "";
    }
  }

  // http://azone.vn/ngay-hoang-dao-ngay-hac-dao-gio-hoang-dao-gio-hac-dao-la-gi-d68825
  static List<HHDao> getHourOfHoangDao(DateTime solarDateTime) {
    String chiOfDay =
        getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
    List<HHDao> result = new List<HHDao>();
    switch (chiOfDay) {
      case DAN:
      case THAN:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
        ];
        break;
      case MAO:
      case DAU:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
        ];
        break;
      case THIN:
      case TUAT:
        result = [
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      case TI:
      case HOI:
        result = [
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      case TY:
      case NGO:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
        ];
        break;
      case SUU:
      case MUI:
        result = [
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      default:
        return [];
    }
    return result;
  }

  static List<HHDao> getHourOfHacDao(DateTime solarDateTime) {
    String chiOfDay =
        getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
    List<HHDao> result;
    switch (chiOfDay) {
      case DAN:
      case THAN:
        result = [
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      case MAO:
      case DAU:
        result = [
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      case THIN:
      case TUAT:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
        ];
        break;
      case TI:
      case HOI:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: MAO, durationHour: getDurationHourByChi(MAO)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: THAN, durationHour: getDurationHourByChi(THAN)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
        ];
        break;
      case TY:
      case NGO:
        result = [
          new HHDao(chi: DAN, durationHour: getDurationHourByChi(DAN)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: TI, durationHour: getDurationHourByChi(TI)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: TUAT, durationHour: getDurationHourByChi(TUAT)),
          new HHDao(chi: HOI, durationHour: getDurationHourByChi(HOI)),
        ];
        break;
      case SUU:
      case MUI:
        result = [
          new HHDao(chi: TY, durationHour: getDurationHourByChi(TY)),
          new HHDao(chi: SUU, durationHour: getDurationHourByChi(SUU)),
          new HHDao(chi: THIN, durationHour: getDurationHourByChi(THIN)),
          new HHDao(chi: NGO, durationHour: getDurationHourByChi(NGO)),
          new HHDao(chi: MUI, durationHour: getDurationHourByChi(MUI)),
          new HHDao(chi: DAU, durationHour: getDurationHourByChi(DAU)),
        ];
        break;
      default:
        return [];
    }
    return result;
  }

  static int getKhacOfTime() {
    int hour = DateTime.now().hour;
    if ((hour >= 23 && hour <= 1) || (hour >= 11 && hour <= 13)) {
      return 1;
    }
    if ((hour >= 1 && hour <= 3) || (hour >= 13 && hour <= 15)) {
      return 2;
    }
    if ((hour >= 3 && hour <= 5) || (hour >= 15 && hour <= 17)) {
      return 3;
    }
    if ((hour >= 5 && hour <= 7) || (hour >= 17 && hour <= 19)) {
      return 4;
    }
    if ((hour >= 7 && hour <= 9) || (hour >= 19 && hour <= 21)) {
      return 5;
    }
    if ((hour >= 9 && hour <= 11) || (hour >= 21 && hour <= 23)) {
      return 1;
    }
    return 1;
  }

  // https://thientue.vn/cach-tinh-gio-xuat-hanh-tot-xau-cua-ly-thuan-phong
  static String getLongDescriptionGoodBadInDay(DateTime solarDateTime) {
    Solar solar = Solar(
        solarYear: solarDateTime.year,
        solarMonth: solarDateTime.month,
        solarDay: solarDateTime.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    int khac = getKhacOfTime();
    int surplus = (lunar.lunarDay + lunar.lunarMonth + khac - 2) % 6;
    switch (surplus) {
      case 0:
        return "Cầu tài không có lợi hay bị trái ý, ra đi gặp hạn, việc quan phải đòn, gặp ma quỷ cúng lễ mới an.";
        break;
      case 1:
        return "Mọi việc đều tốt, cầu tài đi hướng Tây, Nam. Nhà cửa yên lành, người xuất hành đều bình yên.";
        break;
      case 2:
        return "Vui sắp tới. Cầu tài đi hướng Nam, đi việc quan nhiều may mắn. Người xuất hành đều bình yên. Chăn nuôi đều thuận lợi, người đi có tin vui về.";
        break;
      case 3:
        return "Nghiệp khó thành, cầu tài mờ mịt, kiện cáo nên hoãn lại. Người đi chưa có tin về. Đi hướng Nam tìm nhanh mới thấy, nên phòng ngừa cãi cọ, miệng tiếng rất tầm thường. Việc làm chậm, lâu la nhưng việc gì cũng chắc chắn.";
        break;
      case 4:
        return "Hay cãi cọ, gây chuyện đói kém, phải nên đề phòng, người đi nên hoãn lại, phòng người nguyền rủa, tránh lây bệnh.";
        break;
      case 5:
        return "Rất tốt lành, đi thường gặp may mắn. Buôn bán có lời, phụ nữ báo tin vui mừng, người đi sắp về nhà, mọi việc đều hòa hợp, có bệnh cầu tài sẽ khỏi, người nhà đều mạnh khỏe.";
        break;
      default:
        return "";
    }
  }

  /* Compute the longitude of the sun at any time.
 * Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
  static double sunLongitude(double jdn) {
    var T, T2, dr, M, L0, DL, lambda, theta, omega;
    T = (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 +
        35999.05030 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    theta = L0 + DL; // true longitude, degree
    // obtain apparent longitude by correcting for nutation and aberration
    omega = 125.04 - 1934.136 * T;
    lambda = theta - 0.00569 - 0.00478 * sin(omega * dr);
    // Convert to radians
    lambda = lambda * dr;
    lambda = lambda -
        pi * 2 * ((lambda / (pi * 2)).round()); // Normalize to (0, 2*PI)
    return lambda;
  }

/* Compute the sun segment at start (00:00) of the day with the given integral Julian day number.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
 * The function returns a number between 0 and 23.
 * From the day after March equinox and the 1st major term after March equinox, 0 is returned.
 * After that, return 1, 2, 3 ...
 */
  static int getSunLongitude(dayNumber, timeZone) {
    return (sunLongitude(dayNumber - 0.5 - timeZone / 24.0) / pi * 12).toInt();
  }

  // https://maphuong.com/dichly/amlich2/
  // https://tuvilyso.org/tool/xemngay/
  static const TIET24 = [
    0,
    21208,
    42467,
    63836,
    85337,
    107014,
    128867,
    150921,
    173149,
    195551,
    218072,
    240693,
    263343,
    285989,
    308563,
    331033,
    353350,
    375494,
    397447,
    419210,
    440795,
    462224,
    483532,
    504758
  ];
  static const TRUC12 = [
    "Kiến",
    "Trừ",
    "Mãn",
    "Bình",
    "Định",
    "Chấp",
    "Phá",
    "Nguy",
    "Thành",
    "Thu",
    "Khai",
    "Bế"
  ];
  // n là số thứ tự (0-23) để lấy Tiết

  static int getTietKhi(int solarYear, int n) {
    if (solarYear < 1900)
      solarYear = 1900;
    else if (solarYear > 2100) solarYear = 2100;
    if (n < 0)
      n = 0;
    else if (n > 23) n = 23;
    var y = ((31556925974.7 * (solarYear - 1900) + TIET24[n] * 60000) +
        DateTime.utc(1900, 1, 6, 2, 5).millisecondsSinceEpoch);
    return DateTime.fromMillisecondsSinceEpoch(y.toInt()).toUtc().day;
  }

  // List Truc Kien in month
  static List getListTrucKienInMonth(DateTime solarDateTime) {
    var t = getTietKhi(solarDateTime.year, (solarDateTime.month - 1) * 2);
    var tiet = solarDateTime.month - 1;
    if (tiet == 0) tiet = 12;
    var kien = (tiet + 1) %
        12; // Trực "Kiến" tùy theo mỗi tiết, tháng 1 "Kiến" tại ngày Dần
    var dd = 0, i = 0;
    var oTruc = new List();

    var T = tiet * 2;
    if (T >= 24) T = 0;

    var ddOffset = (((DateTime.utc(solarDateTime.year, solarDateTime.month, t)
                        .millisecondsSinceEpoch -
                    DateTime.utc(1900, 1, 31).millisecondsSinceEpoch) /
                86400000) +
            40)
        .toInt();

    for (i = 0; i < CHIS.length; i++) {
      dd = ddOffset + i;
      if (DiaChi(dd) == CHIS[kien]) break;
    }

    if (i >= CHIS.length) return [];

    var k, n, d = t - 1;
    for (k = 1; k < t; k++) {
      n = i + (d - k);
      if (n >= 12) n -= 12;
      oTruc.add((12 - n) % 12);
    }

    var dm = TongSoNgay(solarDateTime.year, solarDateTime.month) - d;
    for (k = 0; k < dm; k++) oTruc.add(((12 - i) + k) % 12);
    return oTruc;
  }

  //== Nhập tổng số ngày từ AL (al.dd), phản hồi chi Tý nếu ChiVi là 0
  static String DiaChi(num) {
    return (CHIS[num % 12]);
  }

  // Tổng số ngày. mon [1...12]
  static int TongSoNgay(year, mon) {
    var mdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var nd = mdays[mon - 1];
    if (mon == 2 && isLeapYear(year)) nd++;
    return nd;
  }

  // year là năm Dương Lịch
  static bool isLeapYear(year) {
    return ((0 == (year % 4)) && ((0 != (year % 100)) || (0 == (year % 400))));
    // is it leap year ? returns a boolean
    // ie, if the year divides by 4, but not by 100 except when it divides by
    // 400, it is leap year
  }

  // Get name of truc kien in day
  // return String, Trực Kiến
  static getNameTrucKienInDay(DateTime solarDateTime) {
    List listTrucKien = getListTrucKienInMonth(solarDateTime);
    int truckien = listTrucKien[solarDateTime.day - 1];
    return "Trực " + TRUC12[truckien];
  }

  static Lunar solarToLunarByDateTime(DateTime dateTime) {
    Solar solar = Solar(
        solarYear: dateTime.year,
        solarMonth: dateTime.month,
        solarDay: dateTime.day);
    return LunarSolarConverter.solarToLunar(solar);
  }
}
