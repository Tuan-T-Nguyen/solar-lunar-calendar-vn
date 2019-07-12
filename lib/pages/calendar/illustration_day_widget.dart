import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pageview/bloc/bloc_provider.dart';
import 'package:pageview/bloc/truckien_bloc.dart';
import 'package:pageview/models/date_info.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/sqlite/models/truckien.dart';
import 'package:pageview/sqlite/repository/truckien_repository.dart';
import 'package:pageview/utils/calendar.dart';
import 'package:pageview/utils/ui/skeleton.dart';
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
          double maxWidth = constraints.maxWidth;
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
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 42),
                        padding: EdgeInsets.all(size_4),
                        height: heightBg,
                        alignment: Alignment.center,
                        child: BlocProvider<TruckienBloc>(
                          bloc: _truckienBloc,
                          child: Consumer<DateModel>(
                            builder: (context, dateModel, child) {
                              String truckienName = CalendarUtils.getNameTrucKienInDay(dateModel.getNow());
                              _truckienBloc.getTrucKien(truckienName);
                              return BlocProvider(
                                bloc: _truckienBloc,
                                child: StreamBuilder<TrucKien>(
                                    stream: _truckienBloc.truckien,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          child: SingleChildScrollView(

                                            child: Column(
                                              children: <Widget>[
                                                Text(truckienName, style: illustrationTextStyle,),
                                                Text(
                                                  snapshot.hasData ? snapshot.data.workTodo : '',
                                                  style: TextStyle(color: Colors.green),
                                                ),
                                                Text(
                                                  snapshot.hasData ? snapshot.data.workNotTodo : '',
                                                  style: TextStyle(color: Colors.purple),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Skeleton();
                                      }
                                    }
                                ),
                              );
                            },
                          ),
                        ),
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
