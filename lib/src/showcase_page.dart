import 'package:flutter/material.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/preferences.dart';
import 'package:showcase/src/showcase_list_page.dart';
import 'package:showcase/src/theme_info.dart';

class Showcase extends StatefulWidget {
  final List<Definition> definitions;
  final List<ThemeInfo> themes;
  final String defaultThemeTitle;

  const Showcase({
    Key key,
    this.definitions,
    this.themes,
    this.defaultThemeTitle,
  }) : super(key: key);

  @override
  _ShowcaseState createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  Preferences _preferences;

  @override
  void didChangeDependencies() {
    if (_preferences == null) {
      _preferences = Preferences(onChanged: _listener, themes: _themes());
//      _preferences.addListener(_listener);
    }
    super.didChangeDependencies();
  }

//  @override
//  void dispose() {
//    _preferences.removeListener(_listener);
//    super.dispose();
//  }

  void _listener() {
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseListPage(
      definitions: widget.definitions,
      preferences: _preferences,
    );
  }

  String get _defaultThemeTitle => this.widget.defaultThemeTitle ?? 'App Theme';

  List<ThemeInfo> _themes() {
    var appTheme = ThemeInfo(
      data: Theme.of(context),
      title: _defaultThemeTitle,
    );
    if (this.widget.themes != null) {
      return [
        appTheme,
        ...this.widget.themes,
      ];
    }

    return [appTheme];
  }
}
