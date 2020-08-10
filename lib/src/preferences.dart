import 'package:flutter/material.dart';
import 'package:showcase/src/device_info.dart';
import 'package:showcase/src/device_item.dart';
import 'package:showcase/src/theme_info.dart';
import 'package:showcase/src/theme_item.dart';

class Preferences with ChangeNotifier {
  final VoidCallback onChanged;

  ThemeData _currentTheme;
  BoxConstraints _currentConstraints;
  List<ThemeInfo> _themes;
  List<DeviceInfo> _devices;

  Preferences({
    List<ThemeInfo> themes,
    List<DeviceInfo> devices,
    this.onChanged,
  }) {
    _themes = themes;
    _devices = devices;
    _currentTheme = _themes.elementAt(0).data;
    var deviceInfo = _devices.elementAt(0);
    _currentConstraints = BoxConstraints(
      maxHeight: deviceInfo.height,
      maxWidth: deviceInfo.width,
    );
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

  void changeDevice({double width, double height}) {
    if (_currentConstraints.maxHeight != height ||
        _currentConstraints.maxWidth != width) {
      _currentConstraints = BoxConstraints(maxWidth: width, maxHeight: height);
      _notify();
    }
  }

  List<DeviceItem> get devices => _devices.map((e) {
        return DeviceItem(
          title: e.title,
          width: e.width,
          height: e.height,
          current: _currentConstraints.maxHeight == e.height &&
              _currentConstraints.maxWidth == e.width,
        );
      }).toList();

  List<ThemeItem> get themes => _themes.map((e) {
        return ThemeItem(
          title: e.title,
          data: e.data,
          current: identical(themeData, e.data),
        );
      }).toList();

  ThemeData get themeData => _currentTheme;
  BoxConstraints get constraints => _currentConstraints;
  bool get isEmulateDeviceConstraints =>
      _currentConstraints.maxWidth > 0 || _currentConstraints.maxHeight > 0;
}
