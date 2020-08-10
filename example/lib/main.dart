import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

import 'package:example/scene_with_tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Showcase(
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
              title: 'TextField',
              props: [
                Prop<String>(
                  id: 'data',
                  isRequired: true,
                  initialData: 'foo bar',
                  widget: TextFieldProp(),
                ),
                Prop<bool>(
                  id: 'is_req',
                  isRequired: true,
                  widget: CheckboxProp('Is req?'),
                ),
              ],
              builder: (BuildContext context, PropValues values) {
                if (values.value('is_req') == false) {
                  return Text('failed');
                }
                return Text(values.value('data') ?? 'default');
              }),
          Definition(
            title: 'Custom scene with tabs',
            sceneBuilder: (_, scene) => SceneWithTabs(scene: scene),
            props: [
              Prop<String>(
                id: 'data',
                isRequired: true,
                widget: TextFieldProp(),
              ),
            ],
            builder: (BuildContext context, PropValues values) {
              return Text(values.value('data') ?? 'default');
            },
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
//    _controller.dispose();
  }

  @override
  void init(String initialData) {
    _controller = TextEditingController(text: initialData);
  }
}
