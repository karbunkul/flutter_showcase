import 'package:flutter/widgets.dart';
import 'package:showcase/src/entities/prop.dart';

typedef ItemBuilder = Function(BuildContext context, PropValues values);

class Definition {
  final String title;
  final Widget storyboard;
  final List<Prop> props;
  final ItemBuilder builder;

  Definition({
    @required this.title,
    @required this.builder,
    this.storyboard,
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
    return null;
  }

  bool hasKey(String key) => data.containsKey(key);
}
