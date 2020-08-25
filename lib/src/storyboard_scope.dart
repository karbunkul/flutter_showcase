import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/entities/entity_meta.dart';
import 'package:showcase/src/environment.dart';

class StoryboardScope extends InheritedWidget {
  final Widget content;
  final OnPropChange onPropChange;

  const StoryboardScope({
    Key key,
    @required Widget child,
    @required this.content,
    this.onPropChange,
  })  : assert(child != null),
        assert(content != null),
        super(key: key, child: child);

  static StoryboardScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoryboardScope>();
  }

  void changeTextScaleFactor(double scaleFactor) {
    return Environment().changeTextScaleFactor(scaleFactor);
  }

  void changeTheme(ThemeData themeData) {
    return Environment().changeTheme(themeData);
  }

  void changeDevice({double width, double height}) {
    return Environment().changeDevice(width: width, height: height);
  }

  List<EntityMeta<TextScaleFactorInfo>> get textScaleFactors {
    return Environment().textScaleFactors;
  }

  List<EntityMeta<ThemeInfo>> get themes {
    return Environment().themes;
  }

  List<EntityMeta<DeviceInfo>> get devices {
    return Environment().devices;
  }

  @override
  bool updateShouldNotify(StoryboardScope old) {
    return true;
  }

  ThemeData get themeData => Environment().themeData;

  BoxConstraints get constraints => Environment().constraints;

  double get textScaleFactor => Environment().textScaleFactor;

  bool get isEmulateDeviceConstraints =>
      Environment().isEmulateDeviceConstraints;

  Definition get definition => Environment().definition;
}
