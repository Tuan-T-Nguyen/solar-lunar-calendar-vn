import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data-bg.dart';

class IllustrationDay extends StatelessWidget {
  const IllustrationDay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(4.0, 4.0),
                    color: Colors.grey,
                    blurRadius: 5.0),
              ],
            ),
            height: 80.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  assetsSvgBackground[3],
                  height: 120.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0, right: 4.0),
                    height: 80.0,
                    alignment: Alignment.center,
                    child: Text(
                      "Ngày quốc tế ông già, đàn ông, con trai, bé trai.",
                      style: TextStyle(
                        color: Colors.white,
                        //  fontSize: 12.0,
                      ),
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