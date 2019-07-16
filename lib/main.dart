import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pageview/appbar/calendar-appbar.dart';
import 'package:provider/provider.dart';

import 'appbar/divine-appbar.dart';
import 'bloc/change_date_bloc.dart';
import 'pages/calendar/calendar_page.dart';
import 'pages/divine/divine_page.dart';

void main() => runApp(
  MyApp()
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    // https://developer.school/posts/flutter-provider-and-bloc-in-5-minutes/
    return ChangeNotifierProvider<ChangeDateBloc>.value(
      value: ChangeDateBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFF84655),
          scaffoldBackgroundColor: Colors.transparent,

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
      ),
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
    CalendarPage(),
    DivinePage(),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = _currentTabIndex == 0 ? CalendarAppbar() : DivineAppbar();
    return Scaffold(
      appBar: appBar,
      //appBar: null,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFf84655),
                  Color(0xFFf69390),
                  Color(0xFFf08069),
                ]
            )
        ),
        child: TabBarView(
          controller: _tabController,
          children: _tabList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
            _tabController.animateTo(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Lịch")),
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
