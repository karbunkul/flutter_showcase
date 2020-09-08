import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/preset_info.dart';

class DeviceState {
  final bool current;
  final DeviceInfo entity;

  DeviceState({this.current, this.entity});
}

class ThemeState {
  final bool current;
  final ThemeInfo entity;

  ThemeState({this.current, this.entity});
}

class TextScaleFactorState {
  final bool current;
  final TextScaleFactorInfo entity;

  TextScaleFactorState({this.current, this.entity});
}

class PropState {
  final Prop entity;
  final dynamic value;

  PropState({this.entity, this.value});
}

class PresetState {
  final PresetInfo entity;
  final bool current;

  PresetState({this.entity, this.current});
}
