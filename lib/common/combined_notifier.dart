import 'package:flutter/foundation.dart';
import 'package:account_app_template/common/theme_sets.dart';
import 'package:flutter/material.dart';

class CombinedNotifier with ChangeNotifier {
  ThemeMode? _themeMode;
  Locale? _locale;
  ThemeData? _darkTheme;
  ThemeData? _lightTheme;
  ThemeDataTween? _colorTheme;

  CombinedNotifier();

  Locale getLocale() {
    if (kIsWeb) {
      return const Locale('en', 'US');
    } else {
      return const Locale('en', 'US'); // Default to en_US for other platforms
    }
  }

  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;
  Locale get currentLocale => _locale ?? getLocale();
  ThemeData get darkTheme => _darkTheme ?? ThemeData.dark();
  ThemeData get lightTheme => _lightTheme ?? ThemeData.light();
  ThemeDataTween get colorTheme => _colorTheme ?? Themes.defaultValue;

  void updateLocale(Locale newLocale) {
    _locale != newLocale ? _locale = newLocale : null;
    notifyListeners();
  }

  void toggleThemeMode(ThemeMode newMode) {
    _themeMode != newMode ? _themeMode = newMode : null;
    notifyListeners();
  }

  void updateDarkTheme(ThemeData newTheme) {
    updateColorTheme(ThemeDataTween(begin: lightTheme, end: newTheme));
    notifyListeners();
  }

  void updateLightTheme(ThemeData newTheme) {
    _lightTheme != newTheme ? _lightTheme = newTheme : null;
    updateColorTheme(ThemeDataTween(begin: newTheme, end: darkTheme));
    notifyListeners();
  }

  void updateColorTheme(ThemeDataTween newTheme) {
    _colorTheme != newTheme ? _colorTheme = newTheme : null;
    notifyListeners();
  }
}
