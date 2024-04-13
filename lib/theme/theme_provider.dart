import 'package:flutter/material.dart';
import 'package:music_player/theme/dark_theme.dart';
import 'package:music_player/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;

  ThemeData get theme => _theme;

  bool get isDarkTheme => _theme == darkTheme;

  void toggleTheme() {
    _theme = isDarkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
