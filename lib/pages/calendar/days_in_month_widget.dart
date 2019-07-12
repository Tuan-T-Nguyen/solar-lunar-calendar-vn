import 'package:flutter/material.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:provider/provider.dart';

class DaysInMonthWidget extends StatefulWidget {

  static BuildContext context;

  final DateTime dateTimeSelected;

  DaysInMonthWidget({Key key, this.dateTimeSelected}) :  super(key: key);

  @override
  _DaysInMonthWidgetState createState() => _DaysInMonthWidgetState();
}

class _DaysInMonthWidgetState extends State<DaysInMonthWidget> {

  ScrollController _scrollController;
  DateTime mDateTimeSelected;

  @override
  initState(){
    mDateTimeSelected = widget.dateTimeSelected;
    _scrollController = ScrollController(
      initialScrollOffset: size_100 * mDateTimeSelected.day - size_100,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateItem> _getDaysInMonth(DateTime dateTime) {
    List<DateItem> daysInMonth = [];
    var lastDayDateTime = dateTime.month < 12
        ? new DateTime(dateTime.year, dateTime.month + 1, 0)
        : new DateTime(dateTime.year + 1, 1, 0);
    for (int i = 1; i <= lastDayDateTime.day; i++) {
      daysInMonth.add(new DateItem(solarDateTime: new DateTime(dateTime.year, dateTime.month, i)));
    }
    return daysInMonth;
  }

  Widget _buildRow(DateItem dateItem) {

    int solarDay = dateItem.solarDateTime.day;
    int weekDay = dateItem.solarDateTime.weekday;
    bool isSelected = solarDay == mDateTimeSelected.day;

    return AnimatedContainer(
      duration: Duration(milliseconds: 700),
      curve: Curves.ease,
      color: Colors.transparent,
      width: size_120,
      margin: isSelected ? EdgeInsets.only(left: 3.0, right: 3.0, top: 0, bottom: 18.0) : EdgeInsets.only(left: 3.0, right: 3.0, top: 18.0),
      child: GestureDetector(
        onTap: () {
          if (mDateTimeSelected == null || mDateTimeSelected.day != dateItem.solarDateTime.day) {
            Provider.of<DateModel>(context, listen: false).setNow(dateItem.solarDateTime);
            setState(() {
              mDateTimeSelected = dateItem.solarDateTime;
            });
          }
        },
        child: Card(
          elevation: isSelected ? 12 : 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusCommon),
          ),
          //color: isSelected ? primaryColor : Colors.white,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("$solarDay", style: (weekDay == 6 || weekDay == 7) ? weekdayStyle : dayStyle),
                Text(CalendarUtils.getDayStringBy(weekDay), style: (weekDay == 6 || weekDay == 7) ? weekdayTStyle : dayTStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createListView() {
    List<DateItem> items = _getDaysInMonth(mDateTimeSelected);
    return new ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int position) {
        return _buildRow(items[position]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createListView();
  }

}
