import 'package:flutter/widgets.dart';
import 'package:showcase/src/prop.dart';
import 'package:showcase/src/scene_context.dart';

typedef SceneBuilder = Function(
    BuildContext context, SceneContext sceneContext);

typedef ItemBuilder = Function(BuildContext context, PropValues values);

class Definition {
  final String title;
  final SceneBuilder sceneBuilder;
  final List<Prop> props;
  final ItemBuilder builder;

  Definition({
    @required this.title,
    @required this.builder,
    this.sceneBuilder,
    this.props,
  });
}

class PropValues {
  final Map<String, dynamic> data;

  PropValues(this.data);

  dynamic value(String id) {
    if (data.containsKey(id)) {
      return data[id];
    }
  }
}
