import 'package:flutter/material.dart';
import 'package:pageview/models/hh_dao.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/calendar.dart';

class Hour2HDWidget extends StatefulWidget {
  final List<HHDao> hhDao;
  final Color bgColor;
  static const BorderRadius cardBorderRadius =
      const BorderRadius.all(Radius.circular(size_12));

  Hour2HDWidget({@required this.hhDao, @required this.bgColor});

  @override
  _Hour2HDWidgetState createState() => _Hour2HDWidgetState();
}

class _Hour2HDWidgetState extends State<Hour2HDWidget> {
  final double _widthCard = 80.0;
  final double _leftRightBtnWidth = 40;

  bool isHideLeftButton = true;
  bool isHideRightButton = false;

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isHideRightButton = true;
        isHideLeftButton = false;
      });
    }
    else if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isHideRightButton = false;
        isHideLeftButton = true;
      });
    } else {
      setState(() {
        isHideRightButton = false;
        isHideLeftButton = false;
      });
    }
  }

  _moveLeft() {
    _controller.animateTo(_controller.offset - _widthCard,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveRight() {
    _controller.animateTo(_controller.offset + _widthCard,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.hhDao.length,
            itemBuilder: (context, index) {
              String path = getIconZodiac(widget.hhDao[index].chi);
              return Material(
                elevation: 0,
                borderRadius: Hour2HDWidget.cardBorderRadius,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: Hour2HDWidget.cardBorderRadius,
                      child: Image.asset(
                        path,
                        height: 100,
                        width: _widthCard,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.bgColor.withOpacity(0.35),
                        // color: Colors.transparent,
                        borderRadius: Hour2HDWidget.cardBorderRadius,
                      ),
                      height: 100,
                      width: _widthCard,
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                          width: _widthCard,
                          alignment: Alignment.center,
                          child: Text(
                            widget.hhDao[index].chi,
                            style: descriptionHDBoldStyle,
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                            width: _widthCard,
                            alignment: Alignment.center,
                            child: Text(
                              widget.hhDao[index].durationHour,
                              style: descriptionHDBoldStyle,
                            ))),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: size_12,
              );
            },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: !isHideLeftButton ? Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(3.0, 3.0),
                        color: Colors.black38,
                        blurRadius: 10.0),
                  ]),
              width: _leftRightBtnWidth,
              height: _leftRightBtnWidth,
              child: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: widget.bgColor,
                  ),
                  onPressed: _moveLeft)) : Container(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: !isHideRightButton ? Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(3.0, 3.0),
                        color: Colors.black38,
                        blurRadius: 10.0),
                  ]),
              width: _leftRightBtnWidth,
              height: _leftRightBtnWidth,
              child: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: widget.bgColor,
                  ),
                  onPressed: _moveRight)) : Container(),
        ),
      ],
    );
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
