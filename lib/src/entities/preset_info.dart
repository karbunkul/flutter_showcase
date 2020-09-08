import 'package:flutter/foundation.dart';

class PresetInfo {
  final String title;
  final Map<String, dynamic> values;

  PresetInfo({@required this.title, @required this.values})
      : assert(title != null),
        assert(values != null);
}
