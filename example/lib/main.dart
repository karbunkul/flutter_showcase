import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Showcase(
        textScaleFactors: [
          TextScaleFactorInfo(scaleFactor: 0.85, title: 'Small size'),
          TextScaleFactorInfo(scaleFactor: 1.0, title: 'Normal size'),
          TextScaleFactorInfo(scaleFactor: 1.3, title: 'Large size'),
          TextScaleFactorInfo(scaleFactor: 2.0, title: 'Extra-large size'),
        ],
        themes: [
          ThemeInfo(data: ThemeData.dark(), title: 'Dark Theme'),
          ThemeInfo(
            data: ThemeData(primarySwatch: Colors.red),
            title: 'Red Theme',
          ),
          ThemeInfo(
            data: ThemeData(primarySwatch: Colors.amber),
            title: 'Amber Theme',
          ),
        ],
        definitions: [
          Definition(
            props: [
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
            ],
            builder: (context, values) {
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
            },
            title: 'Foo bar',
          ),
          Definition(
            storyboard: FullscreenStoryboard(),
            props: [
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
            ],
            builder: (context, values) {
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
            },
            title: 'Fullscreen Foo bar',
          ),
        ],
      ),
    );
  }
}

class CheckboxProp implements PropWidget<bool> {
  final String title;

  CheckboxProp(this.title);
  @override
  Widget builder(BuildContext context, bool value, onChanged) {
    return Row(
      children: <Widget>[
        Checkbox(value: value ?? false, onChanged: onChanged),
        SizedBox(width: 16),
        Text(this.title ?? ''),
      ],
    );
  }

  @override
  void dispose() {}

  @override
  void init(bool initialData) {}
}

class TextFieldProp implements PropWidget<String> {
  TextEditingController _controller;
  @override
  Widget builder(BuildContext context, String value, onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  void init(String initialData) {
    _controller = TextEditingController(text: initialData);
  }
}

class SliderProp implements PropWidget<double> {
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
  void dispose() {}

  @override
  void init(double initialData) {
    _data = initialData ?? min;
  }
}
