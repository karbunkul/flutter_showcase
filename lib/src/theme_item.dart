import 'package:flutter/material.dart';

class ThemeItem {
  final ThemeData data;
  final String title;
  final bool current;

  ThemeItem({this.data, this.title, this.current = false});

  ThemeItem copyWith({ThemeData data, String title, bool current}) {
    return ThemeItem(
      data: data ?? this.data,
      title: title ?? this.title,
      current: current != null ? current : this.current,
    );
  }
}
