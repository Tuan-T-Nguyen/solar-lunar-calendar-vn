import 'package:pageview/models/hh_dao.dart';

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

  static String getDurationHourByChi(String chi) {
    switch (chi) {
      case TY: return "23 - 1 giờ";
      case SUU: return "1 - 3 giờ";
      case DAN: return "3 - 5 giờ";
      case MAO: return "5 - 7 giờ";
      case THIN: return "7 - 9 giờ";
      case TI: return "9 - 11 giờ";
      case NGO: return "11 - 13 giờ";
      case MUI: return "13 - 15 giờ";
      case THAN: return "15 - 17 giờ";
      case DAU: return "17 - 19 giờ";
      case TUAT: return "19 - 21 giờ";
      case HOI: return "21 - 23 giờ";
      default: return "";
    }
  }
  // http://azone.vn/ngay-hoang-dao-ngay-hac-dao-gio-hoang-dao-gio-hac-dao-la-gi-d68825
  static List<HHDao> getHourOfHoangDao(DateTime solarDateTime) {
    String chiOfDay = getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
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
    String chiOfDay = getChiOfDay(solarDateTime.day, solarDateTime.month, solarDateTime.year);
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


  // https://thientue.vn/cach-tinh-gio-xuat-hanh-tot-xau-cua-ly-thuan-phong
  static String getLongDescriptionGoodBadInDay(int surplus) {

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
}
