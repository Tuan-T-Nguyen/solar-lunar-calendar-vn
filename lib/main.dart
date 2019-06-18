import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pageview/pages/calendar/days_in_month.dart';
import 'package:provider/provider.dart';
import './utils/date_picker_vn.dart';

import 'data-bg.dart';
import 'models/date_info.dart';
import 'pages/calendar/calendar_page.dart';
import 'pages/divine/divine_page.dart';

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
//      initialRoute: '/',
//      routes: {
//        '/': (context) => CalendarPage(),
//        '/divine': (context) => DivinePage(),
//      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex = 0;
  List<Widget> _tabList = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: CalendarPage(),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: DivinePage(),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ahihi"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
            _tabController.animateTo(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Lịch")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Bói")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Chuyển đổi")),
          ]),
    );
  }

  _handleTabSelection() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }
}

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}

//class _HomePageState extends State<HomePage> {
//
//  List<DateItem> _daysInMonth = [];
////  DateModel _selectedDateModel;
//  @override
//  initState() {
//    super.initState();
//    DateTime _now = new DateTime.now();
//
//    select.setNow(_now);
//
//    var lastDayDateTime = _now.month < 12
//        ? new DateTime(_now.year, _now.month + 1, 0)
//        : new DateTime(_now.year + 1, 1, 0);
//    for (int i = 1; i <= lastDayDateTime.day; i++) {
//
//      _daysInMonth
//          .add(new DateItem(new DateTime(_now.year, _now.month, i)));
//    }
//  }
//
//  DateTime selectedDateModal = DateTime.now();
//
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePickerCustom(
//      context: context,
//      initialDate: _selectedDateInfo.now,
//      firstDate: DateTime(2015, 8),
//      lastDate: DateTime(2101),
//      locale: const Locale('vi', 'VN'),
//    );
//
//    if (picked != null && picked != selectedDateModal)
//      setState(() {
//        _selectedDateInfo.now = picked;
//
//        var lastDayDateTime = picked.month < 12
//            ? new DateTime(picked.year, picked.month + 1, 0)
//            : new DateTime(picked.year + 1, 1, 0);
//        _daysInMonth = [];
//        for (int i = 1; i <= lastDayDateTime.day; i++) {
//          _daysInMonth
//              .add(new DateInfo(now: new DateTime(picked.year, picked.month, i)));
//        }
//
//      });
//  }
//
//  Widget _buildMonthYear() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          "Tháng ${_selectedDateInfo.now.month} - ${_selectedDateInfo.now.year}",
//          style: TextStyle(
//            color: Colors.blueAccent,
//          ),
//        ),
//        Icon(
//          Icons.arrow_drop_down,
//          color: Colors.blueAccent,
//        )
//      ],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      //backgroundColor: Colors.white,
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        elevation: 0,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.today,
//              color: Colors.blueAccent,
//            ),
//            onPressed: () {
//              setState(() {
//                _selectedDateInfo.now = new DateTime.now();
//              });
//            },
//            tooltip: "Hôm nay",
//          ),
//        ],
//        centerTitle: true,
//        title: GestureDetector(
//          onTap: () => _selectDate(context),
//          child: Container(
//            child: _buildMonthYear(),
//          ),
//        ),
//      ),
//      body: Container(
//        padding: EdgeInsets.symmetric(horizontal: 12.0),
//        color: Colors.white,
//        child: Column(
//          children: <Widget>[
//            // Days
//            Container(
//              margin: EdgeInsets.symmetric(vertical: 8.0),
//              height: 130.0,
//              child: DaysInMonth(
//                items: _daysInMonth,
//                selectedDay: _selectedDateInfo.now.day,
//              ),
//            ),
//
//            // Illustrations
//            Container(
//              height: 120.0,
//              margin: EdgeInsets.only(bottom: 10.0),
//              child: Stack(
//                alignment: Alignment.bottomCenter,
//                children: <Widget>[
//                  Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                      color: Theme.of(context).primaryColor,
//                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          // bottomLeft
//                            offset: Offset(4.0, 4.0),
//                            color: Colors.grey,
//                            blurRadius: 5.0),
//                      ],
//                    ),
//                    height: 80.0,
//                  ),
//                  Container(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        SvgPicture.asset(
//                          assetsSvgBackground[3],
//                          height: 120.0,
//                        ),
//                        Expanded(
//                          child: Container(
//                            margin: EdgeInsets.only(top: 40.0),
//                            height: 80.0,
//                            alignment: Alignment.center,
//                            child: Text(
//                              "Ngày quốc tế ông già, đàn ông, con trai, bé trai.",
//                              style: TextStyle(
//                                color: Colors.white,
//                                //  fontSize: 12.0,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//
//            // Lunar Info
//            Expanded(
//              child: Container(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Chip(
//                          backgroundColor: Theme.of(context).primaryColor,
//                          label: Text(
//                            'Năm ' + _selectedDateInfo.getCanChiYear(),
//                            style: TextStyle(
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                    Expanded(
//                      child: Container(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                Text("Ngày"),
//                                Text("${_selectedDateInfo.solarToLunar().lunarDay}",
//                                    style: TextStyle(
//                                        color: _selectedDateInfo.solarToLunar().lunarDay == 15 ||
//                                            _selectedDateInfo.solarToLunar().lunarDay == 1
//                                            ? Theme.of(context).primaryColor
//                                            : Colors.blueAccent,
//                                        fontSize: 100.0,
//                                        fontWeight: FontWeight.bold)),
//                                Text(
//                                    _selectedDateInfo.getCanChiDay(),
//                                    style: TextStyle(
//                                        color: Colors.blueAccent,
//                                        fontSize: 22.0,
//                                        fontWeight: FontWeight.bold)),
//                              ],
//                            ),
//                            Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                Text("Tháng"),
//                                Text("${_selectedDateInfo.solarToLunar().lunarMonth}",
//                                    style: TextStyle(
//                                        color: Colors.blueAccent,
//                                        fontSize: 100.0,
//                                        fontWeight: FontWeight.bold)),
//                                Text(
//                                    _selectedDateInfo.getCanChiMonth(),
//                                    style: TextStyle(
//                                        color: Colors.blueAccent,
//                                        fontSize: 22.0,
//                                        fontWeight: FontWeight.bold)),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Icons.calendar_today), title: Text("Lịch")),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.query_builder), title: Text("Bói")),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.wallpaper), title: Text("Cung")),
//        ],
//        onTap: (index) {},
//      ),
////      floatingActionButton: FloatingActionButton(
////        onPressed: () {},
////        child: Icon(Icons.add),
////      ),
////      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//    );
//  }
//}
