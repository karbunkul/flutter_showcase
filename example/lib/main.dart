import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:example/definitions/definitions.dart';
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
          FooBarDefinition(),
          FullscreenFooBarDefinition(),
          NotifyScopeDefinition(),
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
