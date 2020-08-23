import 'package:flutter/material.dart';
import 'package:showcase/src/storyboard_scope.dart';

class DevicePreviewArea extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const DevicePreviewArea({Key key, @required this.child, this.padding})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var device = StoryboardScope.of(context)
        .devices
        .firstWhere((device) => device.current);

    if (device.width > 0 && device.height > 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: padding,
            title: Text('Preview area emulate device'),
            subtitle: Text(device.title),
            trailing: Text(
              '${device.width.toInt()} x ${device.height.toInt()}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 16),
          buildChild(),
        ],
      );
    }
    return buildChild();
  }

  Widget buildChild() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 150),
      child: Center(child: child),
    );
  }
}
