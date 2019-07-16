import 'package:flutter/material.dart';
import 'package:pageview/models/hh_dao.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/size_config.dart';

class HHDaoDetail extends StatefulWidget {
  final HHDao hhDao;

  HHDaoDetail(this.hhDao);

  @override
  _HHDaoDetailState createState() => _HHDaoDetailState();
}

class _HHDaoDetailState extends State<HHDaoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
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
          //color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: size_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Giờ ${widget.hhDao.chi}', style: descriptionHDBoldStyle,),
                        SizedBox(width: size_12,),
                        Text(widget.hhDao.durationHour, style: descriptionHDBoldStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height: size_20,),
                  Hero(
                    tag: widget.hhDao.chi,
                    child: Container(
                      height: 300,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
                          child: Image.asset(widget.hhDao.getZodiacImage(true), fit: BoxFit.fitHeight,)),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0)),
                  child: Container(
                    height: SizeConfig.screenHeight - (size_16 + size_20 + 300 + size_30),
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(size_16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size_12,),
                          Text("ABC"),
                          Text("ABC"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
