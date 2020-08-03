import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/widgets.dart';

class Prop<T> implements PropDefinition {
  final bool isRequired;
  final String id;
  final T initialData;
  final PropWidget<T> widget;

  const Prop({
    @required this.id,
    @required this.widget,
    this.isRequired = false,
    this.initialData,
  });
}
