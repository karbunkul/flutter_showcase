import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/device_item.dart';
import 'package:showcase/src/theme_item.dart';

typedef DeviceChanged = Function({double width, double height});

class SceneContext {
  final Definition definition;
  final Widget child;
  final OnPropChange onPropChange;
  final ValueChanged<ThemeData> changeTheme;
  final DeviceChanged changeDevice;
  final List<ThemeItem> themes;
  final List<DeviceItem> devices;
  final bool isEmulateDeviceConstraints;

  SceneContext({
    @required this.definition,
    @required this.child,
    this.onPropChange,
    this.changeTheme,
    this.themes,
    this.devices,
    this.isEmulateDeviceConstraints,
    this.changeDevice,
  });
}
