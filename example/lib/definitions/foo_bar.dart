import 'package:example/props/props.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

class FooBarDefinition extends Definition {
  @override
  builder(_, values) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(values.value('data')),
        SizedBox(height: 32),
        Container(
          width: values.value('width'),
          height: values.value('height'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  List<Prop> get props {
    return [
      Prop<String>(
        id: 'data',
        widget: TextFieldProp(),
        initialData: 'Hello World',
      ),
      Prop<double>(
        initialData: 70,
        id: 'width',
        widget: SliderProp(min: 30, max: 150),
      ),
      Prop<double>(
        initialData: 60,
        id: 'height',
        widget: SliderProp(min: 30, max: 150),
      ),
    ];
  }

  @override
  String get title => 'FooBar';
}
