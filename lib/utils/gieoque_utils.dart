import 'package:pageview/utils/constants.dart';

class GieoQueUtils {

  /// Get name que of 3 coin
  static String getNameQue(int coin_1, int coin_2, coin_3) {
    if (coin_1 == COIN_FRONT && coin_2 == COIN_FRONT && coin_3 == COIN_FRONT) {
      return QUE_DUONG;
    }
    if (coin_1 == COIN_BACK && coin_2 == COIN_BACK && coin_3 == COIN_BACK) {
      return QUE_AM;
    }
    if ( (coin_1 == COIN_FRONT && coin_2 == COIN_FRONT)
        || (coin_1 == COIN_FRONT && coin_3 == COIN_FRONT)
        || (coin_2 == COIN_FRONT && coin_3 == COIN_FRONT) ) {
      return QUE_AM;
    }

    if ( (coin_1 == COIN_BACK && coin_2 == COIN_BACK)
        || (coin_1 == COIN_BACK && coin_3 == COIN_BACK)
        || (coin_2 == COIN_BACK && coin_3 == COIN_BACK) ) {
      return QUE_DUONG;
    }

    return '';
  }
}