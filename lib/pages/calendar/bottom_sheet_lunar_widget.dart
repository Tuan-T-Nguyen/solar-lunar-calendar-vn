import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/colors.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'lunar_info_widget.dart';

class BottomSheetLunarWidget extends StatefulWidget {
  @override
  _BottomSheetLunarWidgetState createState() => _BottomSheetLunarWidgetState();
}

class _BottomSheetLunarWidgetState extends State<BottomSheetLunarWidget>  with SingleTickerProviderStateMixin {

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
    Tween<double>(begin: SizeConfig.screenHeight / 2 - 80, end: sheetTop)
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
    _animationController.dispose();
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
  }
}

class BottomSheetContainer extends StatelessWidget {

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
                LunarInfoWidget(),
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