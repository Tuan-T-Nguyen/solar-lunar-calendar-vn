import 'package:flutter_test/flutter_test.dart';
import 'package:pageview/utils/constants.dart';
import 'package:pageview/utils/gieoque_utils.dart';

void main() {
  group("Test get name que", () {
    test("3 coins are front", () {
      String que = GieoQueUtils.getNameQue(COIN_FRONT, COIN_FRONT, COIN_FRONT);
      expect(que, QUE_DUONG);
    });

    test("3 coins are back", () {
      String que = GieoQueUtils.getNameQue(COIN_BACK, COIN_BACK, COIN_BACK);
      expect(que, QUE_AM);
    });

    test("2 coins are front", () {
      String que1 = GieoQueUtils.getNameQue(COIN_FRONT, COIN_FRONT, COIN_BACK);
      expect(que1, QUE_AM);

      String que2 = GieoQueUtils.getNameQue(COIN_BACK, COIN_FRONT, COIN_FRONT);
      expect(que2, QUE_AM);

      String que3 = GieoQueUtils.getNameQue(COIN_FRONT, COIN_BACK, COIN_FRONT);
      expect(que3, QUE_AM);
    });

    test("2 coins are back", () {
      String que1 = GieoQueUtils.getNameQue(COIN_BACK, COIN_BACK, COIN_FRONT);
      expect(que1, QUE_DUONG);

      String que2 = GieoQueUtils.getNameQue(COIN_BACK, COIN_FRONT, COIN_BACK);
      expect(que2, QUE_DUONG);

      String que3 = GieoQueUtils.getNameQue(COIN_FRONT, COIN_BACK, COIN_BACK);
      expect(que3, QUE_DUONG);
    });
  });
}