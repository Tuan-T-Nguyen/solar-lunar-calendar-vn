import 'package:flutter/material.dart';
import 'package:pageview/bloc/change_date_bloc.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'hour_2hd_widget.dart';
import 'lunar_info_widget.dart';

class BottomSheetLunarWidget extends StatefulWidget {
  @override
  _BottomSheetLunarWidgetState createState() => _BottomSheetLunarWidgetState();
}

class _BottomSheetLunarWidgetState extends State<BottomSheetLunarWidget>
    with SingleTickerProviderStateMixin {
  double sheetTop = height_days_in_month + 10;
  Animation<double> animation;
  // Link: https://www.youtube.com/watch?v=80vWzQB0Eto&t=1113s
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        Tween<double>(begin: SizeConfig.screenHeight * 0.5, end: sheetTop)
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.ease,
                reverseCurve: Curves.easeInOut))
              ..addListener(() {
                setState(() {});
              });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChangeDateBloc changeDateBloc = Provider.of<ChangeDateBloc>(context);
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
            child: BottomSheetContainer(),
          ),
        ),
        Positioned(
          top: animation.value - 22,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward();
              },
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text(
                  "Năm ${changeDateBloc.getCanChiYear()}",
                  style: yearLunarTextStyle,
                ),
                avatar: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(_animationController.isCompleted
                      ? Icons.arrow_downward
                      : Icons.arrow_upward),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: animation.value,
            height: 200,
            width: 30,
            child: RaisedButton(
              onPressed: () {
                Provider.of<DateModel>(context, listen: false).setNow(DateTime.now());
              },
              child: Text("Hôm nay", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
              color: Theme.of(context).primaryColor,
            )
        )
      ],
    );
  }
}

class BottomSheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DateModel>(
      builder: (context, dateModel, child) {
        return Container(
          padding: EdgeInsets.only(top: 25),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    LunarInfoWidget(
                      dateTimeSelected: dateModel,
                    ),
                    SizedBox(
                      height: size_20,
                    ),
                    Text(
                      "Giờ Hoàng Đạo".toUpperCase(),
                      style: hourHoangDaoStyle,
                    ),
                    SizedBox(
                      height: size_8,
                    ),
                    Container(
                      height: size_100,
                      child: Hour2HDWidget(
                        hhDao:
                            CalendarUtils.getHourOfHoangDao(dateModel.getNow()),
                        bgColor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: size_20,
                    ),
                    Text(
                      "Giờ Hắc Đạo".toUpperCase(),
                      style: hourHacDaoStyle,
                    ),
                    SizedBox(
                      height: size_8,
                    ),
                    Container(
                      height: size_100,
                      child: Hour2HDWidget(
                        hhDao:
                            CalendarUtils.getHourOfHacDao(dateModel.getNow()),
                        bgColor: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    // LunarInfo(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
