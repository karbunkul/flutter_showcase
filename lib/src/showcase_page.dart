import 'package:flutter/material.dart';
import 'package:showcase/src/entities/definition.dart';
import 'package:showcase/src/entities/device_info.dart';
import 'package:showcase/src/environment.dart';
import 'package:showcase/src/showcase_list_page.dart';
import 'package:showcase/src/entities/text_scale_factor_info.dart';
import 'package:showcase/src/entities/theme_info.dart';

class Showcase extends StatefulWidget {
  final List<Definition> definitions;
  final List<ThemeInfo> themes;
  final List<DeviceInfo> devices;
  final List<TextScaleFactorInfo> textScaleFactors;
  final String defaultThemeTitle;

  const Showcase({
    Key key,
    this.definitions,
    this.themes,
    this.devices,
    this.textScaleFactors,
    this.defaultThemeTitle,
  }) : super(key: key);

  @override
  _ShowcaseState createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  @override
  void didChangeDependencies() {
    Environment().init(
      themes: _themes(),
      devices: _devices(),
      textScaleFactors: _textScaleFactors(),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseListPage(
      definitions: widget.definitions,
    );
  }

  String get _defaultThemeTitle => widget.defaultThemeTitle ?? 'App Theme';

  List<ThemeInfo> _themes() {
    var appTheme = ThemeInfo(
      data: Theme.of(context),
      title: _defaultThemeTitle,
    );
    if (widget.themes != null) {
      return [appTheme, ...widget.themes];
    }

    return [appTheme];
  }

  List<DeviceInfo> _devices() {
    var defaultDevice =
        DeviceInfo(title: 'Don\'t emulate', width: 0, height: 0);
    if (this.widget.devices != null) {
      return [defaultDevice, ...this.widget.devices];
    }

    return [
      defaultDevice,
      DeviceInfo(title: 'iPhone 5/5s/5c/SE', width: 320, height: 568),
      DeviceInfo(title: 'iPhone 6/6s/7/8', width: 375, height: 667),
    ];
  }

  List<TextScaleFactorInfo> _textScaleFactors() {
    return this.widget.textScaleFactors != null ? widget.textScaleFactors : [];
  }
}
