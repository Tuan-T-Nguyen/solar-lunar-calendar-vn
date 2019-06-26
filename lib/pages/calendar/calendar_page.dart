import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageview/models/date_info.dart';
import 'package:provider/provider.dart';

import '../../data-bg.dart';
import 'days_in_month.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.9;
  double expandedHeightFactor = 0.5;
  bool isAnimatedComplete = false;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _heightFactorAnimation = Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[

                // date time selection
//                Container(
//                  margin: EdgeInsets.only(top: 20.0),
//                  height: 40.0,
//                  child: _buildMonthYear(),
//                ),
                // Days
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: 130.0,
                  child: Consumer<DateModel>(
                    builder: (context, dateModel, child) {
                      return DaysInMonth(
                        dateTimeSelected: dateModel.getNow(),
                      );
                    },
                  ),
                ),

                // Illustrations
                new IllustrationDay(),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            // heightFactor: _heightFactorAnimation.value,
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
              ),
              child: new LunarInfo(),
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return getWidget();
      }
    );
  }

  Widget _buildMonthYear() {
    return Consumer<DateModel>(
      builder: (context, dateModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tháng ${dateModel.getNow().month} - ${dateModel.getNow().year}",
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.blueAccent,
            )
          ],
        );
      },
    );
  }
}

class IllustrationDay extends StatelessWidget {
  const IllustrationDay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(3.0, 3.0),
                    color: Colors.black38,
                    blurRadius: 10.0),
              ],
            ),
            height: 80.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  assetsSvgBackground[3],
                  height: 120.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0, right: 4.0),
                    height: 80.0,
                    alignment: Alignment.center,
                    child: Text(
                      "Ngày quốc tế ông già, đàn ông, con trai, bé trai.",
                      style: TextStyle(
                        color: Colors.white,
                        //  fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LunarInfo extends StatelessWidget {
  const LunarInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateModel>(
      builder: (context, dateModel, child) {
        return
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'Năm ' + dateModel.getCanChiYear(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Ngày"),
                            Text("${dateModel.solarToLunar().lunarDay}",
                                style: TextStyle(
                                    color: dateModel.solarToLunar().lunarDay ==
                                                15 ||
                                            dateModel.solarToLunar().lunarDay ==
                                                1
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueAccent,
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold)),
                            Text(dateModel.getCanChiDay(),
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Tháng"),
                            Text("${dateModel.solarToLunar().lunarMonth}",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold)),
                            Text(dateModel.getCanChiMonth(),
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}
