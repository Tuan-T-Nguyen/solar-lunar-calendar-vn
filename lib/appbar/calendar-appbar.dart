import 'package:flutter/material.dart';
import 'package:pageview/bloc/change_date_bloc.dart';
import 'package:pageview/utils/date_picker_vn.dart';
import 'package:provider/provider.dart';

class CalendarAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final ChangeDateBloc changeDateBloc = Provider.of<ChangeDateBloc>(context);
    return AppBar(
      elevation: 0,
      title: GestureDetector(
        child: _buildMonthYear(),
        onTap: () => _selectDate(context),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              changeDateBloc.setNewDateTime(DateTime.now());
            },
            tooltip: "Hôm nay",
          );
        },
      ),

    );
  }

  Widget _buildMonthYear() {
    DateTime now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Tháng ${now.month} - ${now.year}",
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
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePickerCustom(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: const Locale('vi', 'VN'),

    );

    if (picked != null && picked != new DateTime.now()){
      //Provider.of<DateModel>(context, listen: false).setNow(picked);
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
