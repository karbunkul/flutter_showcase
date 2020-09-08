import 'package:example/widgets/notification_manager/message_action.dart';
import 'package:example/widgets/notification_manager/message_settings.dart';
import 'package:example/widgets/notification_manager/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

class NotifyScopeDefinition extends Definition {
  @override
  Widget builder(BuildContext context, PropValues values) {
    return NotificationManager(
      builder: (BuildContext context, MessageEvent event) {
        if (event?.type == MessageType.toast) {
          SnackBarAction action;
          try {
            action = event?.settings?.actions?.elementAt(0)?.build(context)
                as SnackBarAction;
          } catch (e) {
            print(e);
          }

          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              action: action,
              content: ListTile(
                title: Text(event.entity.title),
                subtitle: Text(event.entity.message),
                leading: Icon(Icons.info),
              ),
            ));
        }

        if (event?.type == MessageType.modal) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(event.entity.title),
                  content: ListTile(
                    title: Text(event.entity.message ?? 'Not set'),
                    leading: Icon(Icons.info),
                  ),
                );
              });
        }
      },
      child: NotifyScaffold(),
    );
  }

  @override
  List<Prop> get props {
    return [];
  }

  @override
  Widget get storyboard {
    return FullscreenStoryboard();
  }

  @override
  String get title => 'NotifyScope';
}

class NotifyScaffold extends StatelessWidget {
  const NotifyScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressed(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _onPressed(BuildContext context) {
    NotificationScope.of(context).showToast(
      Message(title: 'Alert 23', message: '121212121'),
      settings: MessageSettings(actions: [
        MessageSnackBarAction(
          label: 'RETRY',
          onPressed: () => _onPressed(context),
        ),
      ]),
    );
  }
}
