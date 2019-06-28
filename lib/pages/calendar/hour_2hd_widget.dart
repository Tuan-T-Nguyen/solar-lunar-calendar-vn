import 'package:flutter/material.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/utils/calendar.dart';

class Hour2HDWidget extends StatelessWidget {

  final List<String> hours;
  static const BorderRadius cardBorderRadius = const BorderRadius.all(Radius.circular(size_12));

  Hour2HDWidget({this.hours});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String path = getIconZodiac(hours[index]);
          return Material(
            elevation: 0,
            borderRadius: cardBorderRadius,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                    borderRadius: cardBorderRadius,
                    child: Image.asset(
                      path,
                      height: 100,
                      width: 80,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
//                Container(
//                  color: Colors.black.withOpacity(0.5),
//                ),
                Text("asdsd"),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: size_12,
          );
        },
        itemCount: hours.length);
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
