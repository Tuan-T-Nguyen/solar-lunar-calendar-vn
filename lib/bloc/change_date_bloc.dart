import 'package:flutter/material.dart';

class ChangeDateBloc extends ChangeNotifier {
  DateTime _dateTime = new DateTime.now();

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime inputDateTime) {
    _dateTime = inputDateTime;
    notifyListeners();
  }

  setNewDateTime(DateTime inputDateTime) {
    dateTime = inputDateTime;
  }
}