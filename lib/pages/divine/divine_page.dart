import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/constants.dart';
import 'package:pageview/utils/gieoque_utils.dart';
import 'package:pageview/utils/size_config.dart';

import 'explain_que.dart';

class DivinePage extends StatefulWidget {
  @override
  _DivinePageState createState() => _DivinePageState();
}

class _DivinePageState extends State<DivinePage> with TickerProviderStateMixin {
  double _top = 0;
  int _coinStatus1 = COIN_FRONT;
  int _coinStatus2 = COIN_FRONT;
  int _coinStatus3 = COIN_FRONT;
  int _counter = 0;
  String _que_1 = '',
      _que_2 = '',
      _que_3 = '',
      _que_4 = '',
      _que_5 = '',
      _que_6 = '';
  bool _isExecute = false;

  Random random = new Random();

//  double _sparklesAngle = 0.0;
//  Random random;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 6,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: SizeConfig.screenHeight * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Coin(
                          status: _coinStatus1,
                        ),
                        SizedBox(
                          width: size_4,
                        ),
                        new Coin(
                          status: _coinStatus2,
                        ),
                        SizedBox(
                          width: size_4,
                        ),
                        new Coin(
                          status: _coinStatus3,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  top: _top,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(
                          'assets/coin/turtle-shell.png',
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Que(
                  que: _que_1,
                ),
                Que(
                  que: _que_2,
                ),
                Que(
                  que: _que_3,
                ),
                Que(
                  que: _que_4,
                ),
                Que(
                  que: _que_5,
                ),
                Que(
                  que: _que_6,
                ),
              ],
            ),
          ),
          Container(
            child: Text(_counter == 6
                ? "Bạn gieo được quẻ Lôi Hỏa Phong (豐 fēng)"
                : ""),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: _isExecute
                    ? null
                    : () {
                        if (_counter == 6) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplainQue()));
                        } else {
                          setState(() {
                            _counter++;
                            debugPrint('COUNTER $_counter');
                            _isExecute = true;
                            _top = _top > 0 ? 0 : 65;
                          });

                          new Timer(Duration(seconds: 1), () {
                            setState(() {
                              _coinStatus1 = random.nextInt(2);
                              _coinStatus2 = random.nextInt(2);
                              _coinStatus3 = random.nextInt(2);
                              _top = 0;

                              switch (_counter) {
                                case 1:
                                  {
                                    _que_1 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                                case 2:
                                  {
                                    _que_2 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                                case 3:
                                  {
                                    _que_3 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                                case 4:
                                  {
                                    _que_4 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                                case 5:
                                  {
                                    _que_5 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                                case 6:
                                  {
                                    _que_6 = GieoQueUtils.getNameQue(
                                        _coinStatus1, _coinStatus2, _coinStatus3);
                                    break;
                                  }
                              }
                              _isExecute = false;
                            });
                          });
                        }

                      },
                child: Text(_isExecute
                    ? "Đang gieo"
                    : _counter == 0
                        ? "Gieo quẻ"
                        : _counter < 6
                            ? "Gieo quẻ lần ${_counter + 1}"
                            : "Giải"),
              )),
        ],
      ),
    );
  }
}

class Coin extends StatelessWidget {
  // 0: front
  // 1: back
  final int status;
  const Coin({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      status == COIN_FRONT
          ? 'assets/coin/coin_front.png'
          : 'assets/coin/coin_back.png',
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    );
  }
}

class Que extends StatelessWidget {
  final String que;

  const Que({Key key, this.que}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      que,
      style: que == QUE_AM ? queAmStyle : queDuongStyle,
    );
  }
}
