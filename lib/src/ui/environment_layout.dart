import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:showcase/src/environment.dart';

class EnvironmentLayout extends StatefulWidget {
  final Widget child;
  final VoidCallback onChanged;

  const EnvironmentLayout({Key key, this.child, this.onChanged})
      : super(key: key);
  @override
  _EnvironmentLayoutState createState() => _EnvironmentLayoutState();
}

class _EnvironmentLayoutState extends State<EnvironmentLayout> {
  void _rebuildListener() {
    if ((context as Element).dirty == false) {
      if (widget.onChanged != null) {
        widget.onChanged();
      } else {
        (context as Element).markNeedsBuild();
      }
    }
  }

  @override
  void initState() {
    Environment().addListener(_rebuildListener);
    super.initState();
  }

  @override
  void dispose() {
    Environment().removeListener(_rebuildListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(child: widget.child, data: Environment().themeData);
  }
}
