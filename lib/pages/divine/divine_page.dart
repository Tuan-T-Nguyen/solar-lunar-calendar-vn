import 'package:flutter/material.dart';

class DivinePage extends StatefulWidget {

  @override
  _DivinePageState createState() => _DivinePageState();
}

class _DivinePageState extends State<DivinePage> {

  final dummySnapshot = [
    {"name": "Filip", "votes": 15},
    {"name": "Abraham", "votes": 14},
    {"name": "Richard", "votes": 11},
    {"name": "Ike", "votes": 10},
    {"name": "Justin", "votes": 1},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("ABC");
  }
}
