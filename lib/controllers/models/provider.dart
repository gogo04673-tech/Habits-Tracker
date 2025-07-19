import 'package:flutter/material.dart';
import 'package:habit_track/controllers/notification/notification_service.dart';

class Variables with ChangeNotifier {
  bool _allowReminder = false;

  bool get allowReminder => _allowReminder;

  void changeMode(bool value) async {
    _allowReminder = value;
    notifyListeners();
  }

  String constTime = "09:00 AM";

  String timeReminder = '';

  formatTimeOfDay(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    timeReminder = '$hour:$minute ${time.hour > 12 ? 'AM' : 'PM'}';
    notifyListeners();
  }
}
