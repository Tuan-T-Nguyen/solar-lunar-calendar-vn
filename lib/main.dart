import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import './utils/calendar.dart';

import 'data-bg.dart';

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
      supportedLocales: [
        const Locale('vi'),
        const Locale('en')
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static PageController _pageController = PageController(initialPage: 183);
  var _previousPage = _pageController.initialPage;
  Random random = new Random();
  var _now = new DateTime.now();

  static var _nowConvert = new DateTime.now();
  static Solar solar = Solar(
      solarYear: _nowConvert.year,
      solarMonth: _nowConvert.month,
      solarDay: _nowConvert.day);
  Lunar _lunar = LunarSolarConverter.solarToLunar(solar);

  static const double TEXT_OFFSET = 4.0;

  double heightSolarYearMonth = 40.0;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _now,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        locale: const Locale('vi', 'VN'),
//      initialDatePickerMode:
    );
    
    if (picked != null && picked != selectedDate)
      setState(() {
        _now = picked;
        Solar solar = Solar(
            solarYear: _now.year,
            solarMonth: _now.month,
            solarDay: _now.day);
        _lunar = LunarSolarConverter.solarToLunar(solar);
      });
  }

  Widget _buildMonthYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          CalendarUtils.getDayStringBy(_now.weekday),
          style: TextStyle(
              color: _now.weekday == 6 || _now.weekday == 7
                  ? Theme.of(context).primaryColor
                  : Colors.blueAccent,
              fontSize: 26.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          "${_now.month} / ${_now.year}",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 26.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 15.0,),
//        Icon(Icons.arrow_drop_down, color: Colors.blueAccent,)
      ],
    );
  }

  Widget _buildSolarDay() {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(right: 10.0, bottom: 0.0, left: 10.0, top: 0.0),
          child: SvgPicture.asset(
            // Todo not random, from 1 to 31 and depend on season
            assetsSvgBackground[random.nextInt(assetsSvgBackground.length)],
            fit: BoxFit.fitWidth,
            semanticsLabel: 'Ahihi',
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: SizedBox(
            width: 280,
            child: OutlineButton(onPressed: () => _selectDate(context), child: _buildMonthYear(),),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 365,
        itemBuilder: (context, position) {
          return Container(
            child: Column(
              children: <Widget>[
//                SizedBox(
//                  height: 20.0,
//                ),
//                _buildMonthYear(),
                Expanded(child: _buildSolarDay()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    Divider(
//                      color: Theme.of(context).primaryColor,
//                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            'Âm lịch',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
//                    Divider(
//                      color: Theme.of(context).primaryColor,
//                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Tháng ${_lunar.lunarMonth}",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _lunar.lunarDay.toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 100.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
//                Expanded(
//                  child: Column(
//
//                  ),
//                )
              ],
            ),
          );
        },
        onPageChanged: (int position) {
          setState(() {
            if (_previousPage < position) {
              _now = new DateTime(_now.year, _now.month, _now.day + 1);
            } else {
              _now = new DateTime(_now.year, _now.month, _now.day - 1);
            }
            Solar solar = Solar(
                solarYear: _now.year,
                solarMonth: _now.month,
                solarDay: _now.day);
            _lunar = LunarSolarConverter.solarToLunar(solar);
            _previousPage = position;
          });
          // Todo case position = 0 and max-page
        },
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
