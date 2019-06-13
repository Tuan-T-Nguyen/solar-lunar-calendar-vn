import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import 'data-bg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//  Widget _buildMonthYear(double height) {
//    return Positioned(
//      height: height * 0.1,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Text(
//            "${_now.month} / ${_now.year}",
//            style: TextStyle(
//                color: Colors.blue,
//                fontSize: 26.0,
//                fontWeight: FontWeight.bold),
//          ),
//        ],
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constrains) {
        var width = constrains.maxWidth;
        var height = constrains.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //_buildMonthYear(height),
          ],
        );
      },),
    );
  }

}

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  static PageController _pageController = PageController(initialPage: 183);
  var _now = new DateTime.now();
  int _previousPage = _pageController.initialPage;

  Random random = new Random();

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: 365,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          child: Stack(
            children: <Widget>[
              SvgPicture.asset(
                // Todo not random, from 1 to 31 and depend on season
                assetsSvgBackground[random.nextInt(assetsSvgBackground.length)],
                fit: BoxFit.fitWidth
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          "${_now.month} / ${_now.year}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 150.0,
                        ),
                        Text(
                          "${_now.day}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 180.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView'),
      ),
      body: _buildPageView(),
    );
  }
}
