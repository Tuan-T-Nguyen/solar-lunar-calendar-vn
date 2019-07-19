import 'package:flutter/material.dart';

class ExplainQue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Quẻ 1: Thuần Càn'
        ),
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
                ])),
        child: Stack(
          children: <Widget>[
            Text("☰")
          ],
        ),
      ),
    );
  }
}
