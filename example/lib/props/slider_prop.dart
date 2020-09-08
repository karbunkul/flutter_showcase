import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';

class SliderProp extends PropWidget<double> {
  final double min;
  final double max;

  double _data;

  SliderProp({@required this.min, @required this.max});

  @override
  Widget builder(BuildContext context, double value, onChanged) {
    var _value = value ?? _data;
    return Slider(min: min, max: max, value: _value, onChanged: onChanged);
  }

  @override
  void init(double initialData) {
    _data = initialData ?? min;
  }
}
