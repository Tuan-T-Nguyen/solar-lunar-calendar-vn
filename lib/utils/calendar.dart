
class CalendarUtils {

  // Get day of vietnamese from week day
  static String getDayStringBy(int index) {
    switch(index) {
      case 1: return "Thứ hai";
      case 2: return "Thứ ba";
      case 3: return "Thứ tư";
      case 4: return "Thứ năm";
      case 5: return "Thứ sáu";
      case 6: return "Thứ bảy";
      case 7: return "Chủ nhật";
    }
    return '';
  }
}