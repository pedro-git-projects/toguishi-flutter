import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.system;

  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  bool firstTime = true;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void toggleTheme() {
    if (firstTime) {
      _currentThemeMode =
          brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
      firstTime = false;
    } else {
      _currentThemeMode = _currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    }

    notifyListeners();
  }
}
