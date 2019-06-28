import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';

import '../../data-bg.dart';

class IllustrationDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size_100,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: Stack(
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
            height: size_70,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  assetsSvgBackground[3],
                  height: size_100,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: size_30),
                    padding: EdgeInsets.only(right: size_4),
                    height: size_70,
                    alignment: Alignment.center,
                    child: Text(
                      "Ngày quốc tế ông già, đàn ông, con trai, bé trai.",
                      style: illustrationTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
