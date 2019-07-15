import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pageview/bloc/bloc_provider.dart';
import 'package:pageview/bloc/truckien_bloc.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/sqlite/repository/truckien_repository.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:provider/provider.dart';

import '../../data-bg.dart';

class IllustrationDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TruckienBloc _truckienBloc = TruckienBloc(TrucKienRepository.get());
    return Container(
      //height: size_120,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxHeight = constraints.maxHeight;
          final double heightBg = maxHeight * 0.7;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(borderRadiusCommon)),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(3.0, 3.0),
                        color: Colors.black38,
                        blurRadius: 10.0),
                  ],
                ),
                height: heightBg,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: SvgPicture.asset(
                        assetsSvgBackground[3],
                        height: maxHeight,
                        fit: BoxFit.cover,
                       // semanticsLabel: "ABC",
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Consumer<DateModel>(
                          builder: (context, dateModel, child) {
                            String truckienName = CalendarUtils.getNameTrucKienInDay(dateModel.getNow());
                            _truckienBloc.getTrucKien(truckienName);
                            return BlocProvider(
                              bloc: _truckienBloc,
                              child: StreamBuilder(
                                stream: _truckienBloc.truckien,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      margin: EdgeInsets.only(top: maxHeight - heightBg),
                                      padding: EdgeInsets.symmetric(vertical: size_8, horizontal: size_4),
                                      alignment: Alignment.topLeft,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(width: double.infinity, child: Text(truckienName.toUpperCase(), style: illustrationTextStyle,)),
                                            SizedBox(height: size_4,),
                                            Text(
                                              snapshot.hasData ? snapshot.data.workTodo : '',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                            SizedBox(height: size_4,),
                                            Text(
                                              snapshot.hasData ? snapshot.data.workNotTodo : '',
                                              style: TextStyle(color: Colors.purple),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Text("");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                    ),

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
