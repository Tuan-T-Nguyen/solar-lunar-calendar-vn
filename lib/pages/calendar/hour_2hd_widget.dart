import 'package:flutter/material.dart';
import 'package:pageview/models/hh_dao.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';

import 'hhdao_detail.dart';

class Hour2HDWidget extends StatefulWidget {
  final List<HHDao> hhDao;
  final Color bgColor;
  static const BorderRadius cardBorderRadius =
      const BorderRadius.all(Radius.circular(size_12));

  Hour2HDWidget({@required this.hhDao, @required this.bgColor});

  @override
  _Hour2HDWidgetState createState() => _Hour2HDWidgetState();
}

class _Hour2HDWidgetState extends State<Hour2HDWidget> {
  final double _widthCard = 84.0;
  final double _leftRightBtnWidth = 40;

  bool isHideLeftButton = true;
  bool isHideRightButton = false;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isHideRightButton = true;
        isHideLeftButton = false;
      });
    } else if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isHideRightButton = false;
        isHideLeftButton = true;
      });
    } else {
      setState(() {
        isHideRightButton = false;
        isHideLeftButton = false;
      });
    }
  }

  _moveLeft() {
    _controller.animateTo(_controller.offset - _widthCard,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveRight() {
    _controller.animateTo(_controller.offset + _widthCard,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.separated(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.hhDao.length,
          itemBuilder: (context, index) {
            String path = widget.hhDao[index].getZodiacImage(true);
            return Card(
              elevation: 0,
              child: Material(
                child: InkWell(
                  onTap: () => _showHHDaoDetail(widget.hhDao[index]),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.hhDao[index].chi,
                        child: ClipRRect(
                          borderRadius: Hour2HDWidget.cardBorderRadius,
                          child: Image.asset(
                            path,
                            height: 100,
                            width: _widthCard,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: widget.bgColor.withOpacity(0.35),
                          // color: Colors.transparent,
                          borderRadius: Hour2HDWidget.cardBorderRadius,
                        ),
                        height: 100,
                        width: _widthCard,
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                            width: _widthCard,
                            alignment: Alignment.center,
                            child: Text(
                              widget.hhDao[index].chi,
                              style: descriptionHDBoldStyle,
                            )),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              width: _widthCard,
                              alignment: Alignment.center,
                              child: Text(
                                widget.hhDao[index].durationHour,
                                style: descriptionHDBoldStyle,
                              ))),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: size_12,
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: !isHideLeftButton
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3.0, 3.0),
                            color: Colors.black38,
                            blurRadius: 10.0),
                      ]),
                  width: _leftRightBtnWidth,
                  height: _leftRightBtnWidth,
                  child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: widget.bgColor,
                      ),
                      onPressed: _moveLeft))
              : Container(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: !isHideRightButton
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3.0, 3.0),
                            color: Colors.black38,
                            blurRadius: 10.0),
                      ]),
                  width: _leftRightBtnWidth,
                  height: _leftRightBtnWidth,
                  child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: widget.bgColor,
                      ),
                      onPressed: _moveRight))
              : Container(),
        ),
      ],
    );
  }

  _showHHDaoDetail(HHDao hhDao) {
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: HHDaoDetail(hhDao),
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 500)),
    );
  }
}
