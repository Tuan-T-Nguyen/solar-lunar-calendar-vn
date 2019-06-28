import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:provider/provider.dart';

class LunarInfoWidget extends StatelessWidget {
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
