import 'package:example/widgets/notification_manager/message.dart';
import 'package:example/widgets/notification_manager/message_settings.dart';
import 'package:flutter/widgets.dart';

class MessageEvent {
  final Message entity;
  final MessageType type;
  final MessageSettings settings;

  MessageEvent({
    @required this.entity,
    this.type = MessageType.toast,
    this.settings,
  }) : assert(entity != null);
}
