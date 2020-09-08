import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';

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
    _controller?.dispose();
  }

  @override
  void init(String initialData) {
    _controller = TextEditingController(text: initialData);
  }
}
