import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:pageview/pages/calendar/days_in_month.dart';
import './utils/calendar.dart';
import './utils/date_picker_vn.dart';

import 'data-bg.dart';
import 'models/date_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFff6347),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('vi'), const Locale('en')],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DateInfo> _daysInMonth = [];
  double viewPortFraction = 0.2;
  int currentPage = 183;

//  PageController _pageController;
//  int _previousPage;
//  _now = new DateTime(_now.year, _now.month, _now.day + 1);

  @override
  initState() {
    super.initState();
//    _pageController = PageController(initialPage: currentPage, viewportFraction: viewPortFraction);
//    _previousPage = _pageController.initialPage;
    DateTime _now = new DateTime.now();
    var lastDayDateTime = _now.month < 12
        ? new DateTime(_now.year, _now.month + 1, 0)
        : new DateTime(_now.year + 1, 1, 0);
    for (int i = 1; i <= lastDayDateTime.day; i++) {
      _daysInMonth
          .add(new DateInfo(now: new DateTime(_now.year, _now.month, i)));
    }
  }

  Random random = new Random();
  var _now = new DateTime.now();

  static var _nowConvert = new DateTime.now();
  static Solar solar = Solar(
      solarYear: _nowConvert.year,
      solarMonth: _nowConvert.month,
      solarDay: _nowConvert.day);
  Lunar _lunar = LunarSolarConverter.solarToLunar(solar);

  static const double TEXT_OFFSET = 1.0;

  double heightSolarYearMonth = 40.0;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePickerCustom(
      context: context,
      initialDate: _now,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: const Locale('vi', 'VN'),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        _now = picked;
        Solar solar = Solar(
            solarYear: _now.year, solarMonth: _now.month, solarDay: _now.day);
        _lunar = LunarSolarConverter.solarToLunar(solar);
      });
  }

  Widget _buildMonthYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Tháng ${_now.month} - ${_now.year}",
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
  }

  Widget _buildSolarDay() {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          //color: Colors.green,
          color: _now.weekday == 6 || _now.weekday == 7
              ? Colors.blueAccent
              : Theme.of(context).primaryColor,
//          padding:
//              EdgeInsets.only(right: 10.0, bottom: 0.0, left: 10.0, top: 0.0),
          child: SvgPicture.asset(
            // Todo not random, from 1 to 31 and depend on season
            assetsSvgBackground[random.nextInt(assetsSvgBackground.length)],
            //assetsSvgBackground[15],
            fit: BoxFit.fitWidth,
            semanticsLabel: '',
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2 - 40,
          //padding: EdgeInsets.only(bottom: 10.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "${_now.day}",
                style: TextStyle(
                  color: (_now.weekday == 6 || _now.weekday == 7)
                      ? Theme.of(context).primaryColor
                      : Colors.blueAccent,
                  fontSize: 200.0,
                  fontWeight: FontWeight.w900,
                  shadows: <Shadow>[
                    Shadow(
                        // bottomLeft
                        offset: Offset(-TEXT_OFFSET, -TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // bottomRight
                        offset: Offset(TEXT_OFFSET, -TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // topRight
                        offset: Offset(TEXT_OFFSET, TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // topLeft
                        offset: Offset(-TEXT_OFFSET, TEXT_OFFSET),
                        color: Colors.white),
                  ],
                ),
              ),
              Text(
                CalendarUtils.getDayStringBy(_now.weekday),
                style: TextStyle(
                  color: _now.weekday == 6 || _now.weekday == 7
                      ? Theme.of(context).primaryColor
                      : Colors.blueAccent,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                  shadows: <Shadow>[
                    Shadow(
                        // bottomLeft
                        offset: Offset(-TEXT_OFFSET, -TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // bottomRight
                        offset: Offset(TEXT_OFFSET, -TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // topRight
                        offset: Offset(TEXT_OFFSET, TEXT_OFFSET),
                        color: Colors.white),
                    Shadow(
                        // topLeft
                        offset: Offset(-TEXT_OFFSET, TEXT_OFFSET),
                        color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.today,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              setState(() {
                _now = new DateTime.now();
                Solar solar = Solar(
                    solarYear: _now.year,
                    solarMonth: _now.month,
                    solarDay: _now.day);
                _lunar = LunarSolarConverter.solarToLunar(solar);
              });
            },
            tooltip: "Hôm nay",
          ),
        ],
        centerTitle: true,
        title: GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            child: _buildMonthYear(),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Days
            Container(
              alignment: Alignment.center,
              height: 120.0,
              child: DaysInMonth(items: _daysInMonth, selectedDay: _now.day,),
            ),

            // Illustrations
            Flexible(
              flex: 1,
              child: Container(
                height: 120.0,
                child: SvgPicture.asset(
                  assetsSvgBackground[1],
                  // height: 60.0,
                  //width: double.infinity,
                  fit: BoxFit.fitWidth,
                  //      color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            // Lunar Info
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Chip(
                            backgroundColor: Theme.of(context).primaryColor,
                            label: Text(
                              'Lịch âm - Năm ' + CalendarUtils.getCanChiOfYear(_lunar.lunarYear),
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
                                  Text("${_lunar.lunarDay}", style: TextStyle(
                                      color: _lunar.lunarDay == 15 || _lunar.lunarDay == 1
                                          ? Theme.of(context).primaryColor
                                          : Colors.blueAccent,
                                      fontSize: 100.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(CalendarUtils.getCanChiOfDay(
                                      _now.day, _now.month, _now.year), style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Tháng"),
                                  Text("${_lunar.lunarMonth}", style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 100.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(CalendarUtils.getCanChiOfMonth(
                                      _lunar.lunarYear, _lunar.lunarMonth), style: TextStyle(
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("Lịch")),
          BottomNavigationBarItem(
              icon: Icon(Icons.query_builder), title: Text("Bói")),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallpaper), title: Text("Cung")),
        ],
        onTap: (index) {},
      ),
    );
  }
}
