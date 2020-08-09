import 'package:flutter/material.dart';
import 'package:showcase/src/theme_info.dart';
import 'package:showcase/src/theme_item.dart';

class Preferences with ChangeNotifier {
  final VoidCallback onChanged;

  ThemeData _currentTheme;
  List<ThemeInfo> _themes;

  Preferences({
    List<ThemeInfo> themes,
    this.onChanged,
  }) {
    _themes = themes;
    _currentTheme = _themes.elementAt(0).data;
  }

  void _notify() {
    if (onChanged != null) onChanged();
    notifyListeners();
  }

  void changeTheme(ThemeData themeData) {
    if (identical(themeData, _currentTheme) == false) {
      _currentTheme = themeData;
      _notify();
    }
  }

  List<ThemeItem> get themes => _themes.map((e) {
        return ThemeItem(
          title: e.title,
          data: e.data,
          current: identical(themeData, e.data),
        );
      }).toList();

  ThemeData get themeData => _currentTheme;
}
