import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class MessageAction<T> {
  T build(BuildContext context);
}

class MessageSnackBarAction implements MessageAction<SnackBarAction> {
  final String label;
  final GestureTapCallback onPressed;

  MessageSnackBarAction({this.label, this.onPressed});

  @override
  SnackBarAction build(BuildContext context) {
    return SnackBarAction(
      label: label,
      onPressed: onPressed,
    );
  }
}
