import 'package:flutter/foundation.dart';

class TextScaleFactorItem {
  final double scaleFactor;
  final String title;
  final bool current;

  TextScaleFactorItem({
    @required this.scaleFactor,
    @required this.title,
    this.current,
  })  : assert(scaleFactor != null),
        assert(title != null),
        assert(current != null);
}
