import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
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

  double heightSolarYearMonth = 40.0;

  Widget _buildMonthYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          "${_now.month} / ${_now.year}",
          style: TextStyle(
              color: Colors.blueAccent, fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSolarDay() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            // Todo not random, from 1 to 31 and depend on season
              assetsSvgBackground[
              random.nextInt(assetsSvgBackground.length)],
              fit: BoxFit.fitWidth,
            semanticsLabel: 'Ahihi',
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "${_now.day}",
            style: TextStyle(
                color: (_now.weekday == 6 || _now.weekday == 7 )
                    ? Theme.of(context).primaryColor
                    : Colors.blueAccent,
                fontSize: 200.0,
                fontWeight: FontWeight.w900,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 10.0,
                  offset: Offset(2.0, 4.0),
                ),
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
        title: Text('Ahihi'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 365,
        itemBuilder: (context, position) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                _buildMonthYear(),
                Expanded(child: _buildSolarDay()),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(CalendarUtils.getDayStringBy(_now.weekday), style: TextStyle(
                              color: (_now.weekday == 6 || _now.weekday == 7 )
                                  ? Theme.of(context).primaryColor
                                  : Colors.blueAccent,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                )
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
            _previousPage = position;
          });
          // Todo case position = 0 and max-page
        },
      ),
    );
  }
}
