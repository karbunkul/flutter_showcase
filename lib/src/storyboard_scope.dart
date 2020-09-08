import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/entities/entity_meta.dart';
import 'package:showcase/src/entities/preset_info.dart';
import 'package:showcase/src/environment.dart';

class StoryboardScope extends InheritedWidget {
  final Widget content;
  final OnPropChange onPropChanged;
  final ValueChanged<PresetInfo> onPresetChanged;
  final Map<String, dynamic> state;
  final List<PresetState> presets;
  final VoidCallback onResetState;

  StoryboardScope({
    Key key,
    @required Widget child,
    @required this.content,
    @required this.state,
    this.onPropChanged,
    this.onPresetChanged,
    this.onResetState,
    this.presets,
  })  : assert(child != null),
        assert(content != null),
        super(key: key, child: child) {
    Environment().setValues(id: definition.title, values: state);
  }

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

  List<TextScaleFactorState> get textScaleFactors {
    return Environment().textScaleFactors;
  }

  List<ThemeState> get themes {
    return Environment().themes;
  }

  List<DeviceState> get devices {
    return Environment().devices;
  }

  List<PropState> get props {
    return definition.props.map((e) {
      var value;
      if (state.containsKey(e.id)) {
        value = state[e.id];
      }
      return PropState(entity: e, value: value);
    }).toList();
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
