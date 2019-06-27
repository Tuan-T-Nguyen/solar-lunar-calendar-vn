import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/utils/theme.dart';
import 'package:provider/provider.dart';

import '../../data-bg.dart';
import 'days_in_month.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.7,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                // Days
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: HEIGHT_DAYS_IN_MONTH,
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
        BottomSheetLunar(
          screenSize: MediaQuery.of(context).size,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
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
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadiusCommon)),
              color: Colors.white,
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
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
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
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Ngày", style: TextStyle(fontSize: 16.0),),
                        Text("${dateModel.solarToLunar().lunarDay}",
                            style: TextStyle(
                                color: dateModel.solarToLunar().lunarDay ==
                                    15 ||
                                    dateModel.solarToLunar().lunarDay == 1
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
                        Text("Tháng", style: TextStyle(fontSize: 16.0),),
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
              // Hours of Hoang Dao
              Container(
               // color: Colors.green,
                height: 150,
              ),
              Container(
               // color: Colors.blueAccent,
                height: 150,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomSheetLunar extends StatefulWidget {
  //BuildContext context;
  final Size screenSize;
  BottomSheetLunar({Key key, this.screenSize}) : super(key: key);
  @override
  _BottomSheetLunarState createState() => _BottomSheetLunarState();
}

class _BottomSheetLunarState extends State<BottomSheetLunar>
    with SingleTickerProviderStateMixin {
  double sheetTop = HEIGHT_DAYS_IN_MONTH + 10;
  Animation<double> animation;
  // Link: https://www.youtube.com/watch?v=80vWzQB0Eto&t=1113s
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        Tween<double>(begin: widget.screenSize.height / 2 - 80, end: sheetTop)
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.ease,
                reverseCurve: Curves.easeInOut))
              ..addListener(() {
                setState(() {});
              });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: animation.value,
          left: 0,
          child: GestureDetector(
            onTap: () {
              _animationController.isCompleted
                  ? _animationController.forward()
                  : _animationController.reverse();
            },
//            onVerticalDragEnd: (DragEndDetails dragEndDetails) {
//              // upward drag
//              if (dragEndDetails.primaryVelocity < 0.0) {
//                _animationController.reverse();
//              } else if (dragEndDetails.primaryVelocity > 0.0) {
//                _animationController.forward();
//              } else {
//                return;
//              }
//            },
            child: BottomSheetContainer(),
          ),
        ),
        Positioned(
          top: animation.value - 22,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Consumer<DateModel>(builder: (context, dateModel, child) {
              return Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text(
                  'Năm ' + dateModel.getCanChiYear(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();
            },
            child: Icon(_animationController.isCompleted ? Icons.arrow_downward : Icons.arrow_upward),
            mini: true,
            backgroundColor: primaryColor,

          ),
        ),
      ],
    );
    //return
  }
}

class BottomSheetContainer extends StatelessWidget {
  double sheetItemHeight = 110;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
           // child: LunarInfo(),
            child: ListView(
              children: <Widget>[
                LunarInfo(),
                SizedBox(height: 320,)
              ],
            ),
          ),
          // LunarInfo(),
        ],
      ),
    );
  }
}
