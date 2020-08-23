import 'package:flutter/material.dart';

import 'entities/entities.dart';

class Environment with ChangeNotifier {
  static Environment _singleton = Environment._internal();

  BoxConstraints _constraints;
  ThemeData _theme;
  double _textScaleFactor;
  List<ThemeInfo> _themes;
  List<DeviceInfo> _devices;
  List<TextScaleFactorInfo> _textScaleFactors;
  Definition _definition;

  factory Environment() => _singleton;

  Environment._internal();

  BoxConstraints get constraints {
    return _constraints;
  }

  List<DeviceItem> get devices {
    return _devices.map((e) {
      return DeviceItem(
        title: e.title,
        width: e.width,
        height: e.height,
        current: _constraints.maxHeight == e.height &&
            _constraints.maxWidth == e.width,
      );
    }).toList();
  }

  Definition get definition {
    return _definition;
  }

  bool get isEmulateDeviceConstraints {
    return _constraints.maxWidth > 0 || _constraints.maxHeight > 0;
  }

  double get textScaleFactor {
    return _textScaleFactor ?? 1.0;
  }

  List<TextScaleFactorItem> get textScaleFactors {
    return _textScaleFactors.map((e) {
      return TextScaleFactorItem(
        title: e.title,
        scaleFactor: e.scaleFactor,
        current: textScaleFactor == e.scaleFactor,
      );
    }).toList();
  }

  ThemeData get themeData {
    return _theme;
  }

  List<ThemeItem> get themes {
    return _themes.map((e) {
      return ThemeItem(
        title: e.title,
        data: e.data,
        current: identical(themeData, e.data),
      );
    }).toList();
  }

  void changeDevice({double width, double height}) {
    if (_constraints.maxHeight != height || _constraints.maxWidth != width) {
      _constraints = BoxConstraints(maxWidth: width, maxHeight: height);
      _notify();
    }
  }

  void changeTextScaleFactor(double scaleFactor) {
    if (scaleFactor != _textScaleFactor) {
      _textScaleFactor = scaleFactor;
      _notify();
    }
  }

  void changeTheme(ThemeData themeData) {
    if (identical(themeData, _theme) == false) {
      _theme = themeData;
      _notify();
    }
  }

  void changeDefinition(Definition definition) {
    _definition = definition;
    _notify();
  }

  void init({
    @required List<ThemeInfo> themes,
    @required List<DeviceInfo> devices,
    @required List<TextScaleFactorInfo> textScaleFactors,
  }) {
    _themes = themes;
    _devices = devices;
    _textScaleFactors = textScaleFactors;
    _theme = _themes.elementAt(0).data;
    var deviceInfo = _devices.elementAt(0);
    _constraints = BoxConstraints(
      maxHeight: deviceInfo.height,
      maxWidth: deviceInfo.width,
    );
  }

  void _notify() {
    notifyListeners();
  }
}
