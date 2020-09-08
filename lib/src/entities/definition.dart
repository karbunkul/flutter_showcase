import 'package:flutter/widgets.dart';
import 'package:showcase/src/entities/preset_info.dart';
import 'package:showcase/src/entities/prop.dart';

typedef ItemBuilder = Function(BuildContext context, PropValues values);

abstract class Definition {
  String get title;
  List<Prop> get props;
  Widget builder(BuildContext context, PropValues values);
  Widget get storyboard => null;
  List<PresetInfo> get presets => null;
}

class PropValues {
  final Map<String, dynamic> data;

  PropValues(this.data);

  dynamic value(String id) {
    if (data.containsKey(id)) {
      return data[id];
    }
    return null;
  }

  bool hasKey(String key) => data.containsKey(key);
}
