import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      home: PageViewDemo(),
    );
  }
}

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {

  PageController _pageController = PageController(initialPage: 1);


  var _now = new DateTime.now();
  void pageChanged(DismissDirection direction) {
    setState(() {
      if (direction == DismissDirection.startToEnd) {
        _now = new DateTime(_now.year, _now.month, _now.day - 1);
      } else if (direction == DismissDirection.endToStart) {
        _now = new DateTime(_now.year, _now.month, _now.day + 1);
      }
    });
  }

  Widget _buildCalendar() {
    return Center(
      child: Column(
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
                fontSize: 66.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissible() {
    return Dismissible(
      direction: DismissDirection.horizontal,
      onDismissed: (DismissDirection direction) {
        pageChanged(direction);
      },
      key: new ValueKey(_now),
      child: _buildCalendar(),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: 3,
      itemBuilder: (BuildContext context, int position) {
        return Container(
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
                        fontSize: 66.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onPageChanged: (int position) {
        setState(() {
          if (position == 0) {
            _now = new DateTime(_now.year, _now.month, _now.day - 1);
          } else if (position == 2) {
            _now = new DateTime(_now.year, _now.month, _now.day + 1);
          }
        });
        if (position == 0 || position == 2) {
          _pageController.animateToPage(1, duration: Duration (milliseconds: 1000), curve: Curves.ease);
        }
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
