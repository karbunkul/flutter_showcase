import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/theme_info.dart';
import 'package:showcase/src/theme_item.dart';

class SceneContext {
  final Definition definition;
  final Widget child;
  final OnPropChange onPropChange;
  final ValueChanged<ThemeInfo> changeTheme;
  final List<ThemeItem> themes;

  SceneContext({
    @required this.definition,
    @required this.child,
    this.onPropChange,
    this.changeTheme,
    this.themes,
  });
}
