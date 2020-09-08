import 'dart:async';

import 'package:example/widgets/notification_manager/message.dart';
import 'package:example/widgets/notification_manager/message_event.dart';
import 'package:example/widgets/notification_manager/message_settings.dart';
import 'package:flutter/widgets.dart';

class NotificationScope extends InheritedWidget {
  static StreamController<MessageEvent> _messageStream =
      StreamController<MessageEvent>.broadcast(onListen: () {
    _messageStream.add(null);
  });

  NotificationScope({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static NotificationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotificationScope>();
  }

  Stream<MessageEvent> get stream => _messageStream.stream;

  showToast(Message message, {MessageSettings settings}) {
    _messageStream.add(
      MessageEvent(
        settings: settings,
        entity: message,
        type: MessageType.toast,
      ),
    );
  }

  showModal(Message message, {MessageSettings settings}) {
    _messageStream.add(
      MessageEvent(
        entity: message,
        type: MessageType.modal,
      ),
    );
  }

  @override
  bool updateShouldNotify(NotificationScope old) {
    return false;
  }
}
