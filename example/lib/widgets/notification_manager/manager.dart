import 'package:example/widgets/notification_manager/consumer.dart';
import 'package:example/widgets/notification_manager/message_event.dart';
import 'package:example/widgets/notification_manager/notification_manager.dart';
import 'package:example/widgets/notification_manager/scope.dart';
import 'package:flutter/widgets.dart';

typedef MessageBuilder = Function(BuildContext context, MessageEvent event);

class NotificationManager extends StatelessWidget {
  final Widget child;
  final MessageBuilder builder;

  const NotificationManager({
    Key key,
    @required this.child,
    @required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationScope(
      child: NotificationConsumer(
        child: child,
        builder: builder,
      ),
    );
  }
}
