import 'dart:async';

import 'package:example/widgets/notification_manager/manager.dart';
import 'package:example/widgets/notification_manager/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationConsumer extends StatefulWidget {
  final Widget child;
  final MessageBuilder builder;

  const NotificationConsumer({
    Key key,
    this.child,
    @required this.builder,
  }) : super(key: key);

  @override
  _NotificationConsumerState createState() => _NotificationConsumerState();
}

class _NotificationConsumerState extends State<NotificationConsumer> {
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    _subscription = NotificationScope.of(context).stream.listen((event) {
      if (event != null) {
        if (widget.builder == null) throw Exception('builder is required');
        widget.builder(context, event);
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
