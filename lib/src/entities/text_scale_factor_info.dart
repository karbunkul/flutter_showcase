import 'package:flutter/foundation.dart';

class TextScaleFactorInfo {
  final double scaleFactor;
  final String title;

  TextScaleFactorInfo({
    @required this.scaleFactor,
    @required this.title,
  })  : assert(scaleFactor != null),
        assert(title != null);
}
