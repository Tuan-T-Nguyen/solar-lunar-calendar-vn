import 'package:flutter/material.dart';
import 'package:pageview/models/hh_dao.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/calendar.dart';

class Hour2HDWidget extends StatelessWidget {
  final List<HHDao> hhDao;
  final Color bgColor;
  static const BorderRadius cardBorderRadius =
      const BorderRadius.all(Radius.circular(size_12));

  Hour2HDWidget({@required this.hhDao, @required this.bgColor});

  double widthCard = 80.0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String path = getIconZodiac(hhDao[index].chi);
          return Material(
            elevation: 0,
            borderRadius: cardBorderRadius,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: cardBorderRadius,
                  child: Image.asset(
                    path,
                    height: 100,
                    width: widthCard,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(0.35),
                    // color: Colors.transparent,
                    borderRadius: cardBorderRadius,
                  ),
                  height: 100,
                  width: widthCard,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                      width: widthCard,
                      alignment: Alignment.center,
                      child: Text(
                        hhDao[index].chi,
                        style: descriptionHDBoldStyle,
                      )),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: widthCard,
                        alignment: Alignment.center,
                        child: Text(hhDao[index].durationHour, style: descriptionHDBoldStyle,))),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: size_12,
          );
        },
        itemCount: hhDao.length);
  }

  String getIconZodiac(String hour) {
    switch (hour) {
      case CalendarUtils.TY:
        return "assets/12Zodiac/mouse.jpeg";
      case CalendarUtils.SUU:
        return "assets/12Zodiac/buffalo.jpeg";
      case CalendarUtils.DAN:
        return "assets/12Zodiac/tiger.jpeg";
      case CalendarUtils.MAO:
        return "assets/12Zodiac/cat.jpeg";
      case CalendarUtils.THIN:
        return "assets/12Zodiac/dragon.jpeg";
      case CalendarUtils.TI:
        return "assets/12Zodiac/snake.jpeg";
      case CalendarUtils.NGO:
        return "assets/12Zodiac/horse.jpeg";
      case CalendarUtils.MUI:
        return "assets/12Zodiac/goat.jpeg";
      case CalendarUtils.THAN:
        return "assets/12Zodiac/money.jpeg";
      case CalendarUtils.DAU:
        return "assets/12Zodiac/chicken.jpeg";
      case CalendarUtils.TUAT:
        return "assets/12Zodiac/dog.jpeg";
      case CalendarUtils.HOI:
        return "assets/12Zodiac/pig.jpeg";
      default:
        return "";
    }
  }
}
