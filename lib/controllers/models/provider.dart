import 'package:flutter/material.dart';
import 'package:habit_track/controllers/notification/noti_service.dart';

class Variables with ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  void changeMode(bool value) async {
    _darkMode = value;
    await NotiService().initialize();
    DateTime now = DateTime.now();
    await NotiService().scheduleNotification(
      title: "Test Notification",
      body: "This is a test notification",
      hour: 01,
      minute: 05,
    );

    print("${now.hour}: ${now.minute + 1}");
    notifyListeners();
  }
}
