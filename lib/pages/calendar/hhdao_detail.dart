import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/bloc/change_date_bloc.dart';
import 'package:pageview/database/json/models/xuathanh.dart';
import 'package:pageview/database/json/repository/xuathanh_repository.dart';
import 'package:pageview/models/hh_dao.dart';
import 'package:pageview/resources/colors.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/constants.dart';
import 'package:pageview/utils/size_config.dart';
import 'package:provider/provider.dart';

class HHDaoDetail extends StatefulWidget {
  final HHDao hhDao;

  HHDaoDetail(this.hhDao);

  @override
  _HHDaoDetailState createState() => _HHDaoDetailState();
}

class _HHDaoDetailState extends State<HHDaoDetail> {
  @override
  Widget build(BuildContext context) {
    final ChangeDateBloc changeDateBloc = Provider.of<ChangeDateBloc>(context);
    DateTime dateTimeXuatHanh = DateTime(
        changeDateBloc.dateTime.year,
        changeDateBloc.dateTime.month,
        changeDateBloc.dateTime.day,
        widget.hhDao.getStartTime());
    Lunar lunar = CalendarUtils.solarToLunarByDateTime(changeDateBloc.dateTime);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Giờ ${widget.hhDao.chi}\t ${widget.hhDao.durationHour}',
          style: descriptionHDBoldStyle,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFFf84655),
              Color(0xFFf69390),
              Color(0xFFf08069),
            ])),
        //color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: size_16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "${changeDateBloc.dateTime.day} / ${changeDateBloc.dateTime.month}",
                              style: valueTextStyle),
                          Text(
                            "Dương lịch",
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size_40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${lunar.lunarDay} / ${lunar.lunarMonth}",
                              style: valueTextStyle),
                          Text(
                            "Âm lịch",
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size_20,
                ),
                Hero(
                  tag: widget.hhDao.chi,
                  child: Container(
                    height: 300,
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40.0)),
                        child: Image.asset(
                          widget.hhDao.getZodiacImage(true),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0)),
                child: Container(
                  height: SizeConfig.screenHeight -
                      (size_16 + size_20 + 300 + size_30),
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(size_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: size_8,
                        ),
                        Text(
                          "Giờ Xuất Hành theo Lý Thuần Phong",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        FutureBuilder<XuatHanh>(
                          future:
                              XuathanhRepository.getXuatHanh(dateTimeXuatHanh),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size_8),
                                        child: Text(
                                          snapshot.data.name,
                                          style: TextStyle(fontSize: 20.0, color: snapshot.data.status == XUATHANH_GOOD ? goodColor : badColor, fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size_8),
                                        child: Text(snapshot.data.description, style: TextStyle(fontSize: 16.0,),)),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size_8),
                                        child: Text(snapshot.data.poem, style: TextStyle(fontSize: 16.0,),)),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
