import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pageview/utils/date_picker_vn.dart';
import 'package:pageview/utils/theme.dart';
import 'package:provider/provider.dart';
import 'models/date_info.dart';
import 'pages/calendar/calendar_page.dart';
import 'pages/divine/divine_page.dart';

void main() => runApp(
  ChangeNotifierProvider(builder: (context) => DateModel(), child: MyApp(),)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return MaterialApp(
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePickerCustom(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: const Locale('vi', 'VN'),

    );

    if (picked != null && picked != new DateTime.now()){
      Provider.of<DateModel>(context, listen: false).setNow(picked);
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          child: _buildMonthYear(),
          onTap: () => _selectDate(context),
        ),
      ),
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

  Widget _buildMonthYear() {
    return Consumer<DateModel>(
      builder: (context, dateModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tháng ${dateModel.getNow().month} - ${dateModel.getNow().year}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            )
          ],
        );
      },
    );
  }
}
