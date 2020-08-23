import 'package:flutter/material.dart';

class ThemeItem {
  final ThemeData data;
  final String title;
  final bool current;

  ThemeItem({this.data, this.title, this.current = false});
}
