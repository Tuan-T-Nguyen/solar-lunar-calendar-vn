import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pageview/resources/sizes.dart';
import 'package:pageview/resources/text_styles.dart';
import 'package:pageview/utils/size_config.dart';

class DivinePage extends StatefulWidget {
  @override
  _DivinePageState createState() => _DivinePageState();
}

class _DivinePageState extends State<DivinePage> with TickerProviderStateMixin {
//  AnimationController sizeAnimationController, inAnimationController, sparklesAnimationController;
//  CurvedAnimation sparklesAnimation;

  double _top = 0;
  int _coinStatus1 = 0;
  int _coinStatus2 = 0;
  int _coinStatus3 = 0;
  int _counter = 0;
  String _que_1 = "";
  String _que_2 = "";
  String _que_3 = "";
  String _que_4 = "";
  String _que_5 = "";
  String _que_6 = "";
  bool _isExecute = false;

  Random random = new Random();

//  double _sparklesAngle = 0.0;
//  Random random;

  @override
  void initState() {
    super.initState();
   // random = new Random();
//    inAnimationController = new AnimationController(duration: new Duration(milliseconds: 150), vsync: this);
//    inAnimationController.addListener((){
//      setState(() {}); // Calls render function
//    });
//
//    sizeAnimationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));
//    sizeAnimationController.addStatusListener((status) {
//      if(status == AnimationStatus.completed) {
//        sizeAnimationController.reverse();
//      }
//    });
//    sizeAnimationController.addListener((){
//      setState(() {});
//    });
//
//    sparklesAnimationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 150));
//    sparklesAnimation = new CurvedAnimation(parent: sparklesAnimationController, curve: Curves.easeIn);
//    sparklesAnimation.addListener((){
//      setState(() { });
//    });

  }
  @override
  void dispose() {
    super.dispose();
//    inAnimationController.dispose();
//    sizeAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    var stackChildren = <Widget>[
//    ];
    return Stack(
      children: <Widget>[
        Positioned(
          top: SizeConfig.screenHeight * 0.5 + size_4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Coin(status: _coinStatus1,),
                SizedBox(
                  width: size_4,
                ),
                new Coin(status: _coinStatus2,),
                SizedBox(
                  width: size_4,
                ),
                new Coin(status: _coinStatus3,),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          top: _top,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            //color: Colors.green,
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
        Positioned(
          top: SizeConfig.screenHeight * 0.5 + size_4 + 80,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$_que_1', style: queDuongStyle,),
                Text('$_que_2', style: queAmStyle,),
                Text('$_que_3', style: queAmStyle,),
                Text('$_que_4', style: queAmStyle,),
                Text('$_que_5', style: queDuongStyle,),
                Text('$_que_6', style: queDuongStyle,),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: _isExecute ? null : () {
                    //new Timer.periodic(Duration(seconds: 1), rung);
                    //sizeAnimationController.forward(from: 0.0);
                    setState(() {
                      _counter++;
                      _isExecute = true;
                      _top = _top > 0 ? 0 : (50 + size_4);
                    });

                    new Timer(Duration(seconds: 2), () {
                      setState(() {
                        _coinStatus1 = random.nextInt(2);
                        _coinStatus2 = random.nextInt(2);
                        _coinStatus3 = random.nextInt(2);
                        _isExecute = false;
                        _top = 0;

                        switch (_counter) {
                          case 1:
                            _que_1= "|";
                            break;
                          case 2:
                            _que_2= "|";
                            break;
                          case 3:
                            _que_3= "|";
                            break;
                          case 4:
                            _que_4= "|";
                            break;
                          case 5:
                            _que_5= "|";
                            break;
                          case 6:
                            _que_6= "|";
                            break;
                        }
                      });
                    });

//                    var firstAngle = _sparklesAngle;
//                    var sparkleRadius = (sparklesAnimationController.value * 50) ;
//                    var sparklesOpacity = (1 - sparklesAnimation.value);
//                    for(int i = 0; i < 5; i++) {
//                      var currentAngle = (firstAngle + ((2*pi)/5)*(i));
//                      var sparklesWidget = new Positioned(child: new Transform.rotate(
//                          angle: currentAngle - pi/2,
//                          child: new Opacity(opacity: sparklesOpacity,
//                              child : new Image.asset("images/sparkles.png", width: 14.0, height: 14.0, ))
//                      ),
//                        left:(sparkleRadius*cos(currentAngle)) + 20,
//                        top: (sparkleRadius* sin(currentAngle)) + 20 ,
//                      );

                    //  stackChildren.add(sparklesWidget);
                 //   }
                  },
                  child: Text(_isExecute
                      ? "Đang gieo"
                      : _counter == 0 ? "Gieo quẻ"
                      : _counter == 6 ? "Giải" : "Gieo quẻ lần ${_counter + 1}"),
                ))),
      ],
    );
  }

//  void rung(Timer t) {
//    sizeAnimationController.forward(from: 0.0);
//    sparklesAnimationController.forward(from: 0.0);
//    setState(() {
//      _sparklesAngle = random.nextDouble() * (2*pi);
//    });
//  }

//    Future<void> randomCoin() async {
//      setState(() {
//        _coinStatus = random.nextInt(1);
//      });
//    }
}

class Coin extends StatelessWidget {
  final int status;
  const Coin({
    Key key,
    this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      status == 0 ? 'assets/coin/coin_front.png' : 'assets/coin/coin_back.png',
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    );
  }
}
