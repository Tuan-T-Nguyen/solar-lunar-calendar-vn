import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';

class LunarInfoWidget extends StatelessWidget {

  final DateModel dateTimeSelected;

  LunarInfoWidget({this.dateTimeSelected});

  @override
  Widget build(BuildContext context) {
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
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 500),
                      child: Text("${dateTimeSelected.solarToLunar().lunarDay}",
                          style: TextStyle(
                              color: dateTimeSelected.solarToLunar().lunarDay ==
                                  15 ||
                                  dateTimeSelected.solarToLunar().lunarDay == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.blueAccent,
                              fontSize: 100.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(dateTimeSelected.getCanChiDay(),
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
                    Text("${dateTimeSelected.solarToLunar().lunarMonth}",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 100.0,
                            fontWeight: FontWeight.bold)),
                    Text(dateTimeSelected.getCanChiMonth(),
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
//              ListView(
//                children: <Widget>[
//                  ListTile(
//                    title: Text("${CalendarUtils.getHourOfHoangDao(_now)[0]}"),
//                  )
//                ],
//              ),
//              Container(
//                // color: Colors.blueAccent,
//                height: 150,
//              ),
        ],
      ),
    );
  }
}
