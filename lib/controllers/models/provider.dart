

import 'package:flutter/material.dart';


class Variables with ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  void changeMode(bool value){
    _darkMode = value;
    
    notifyListeners();
  }
}