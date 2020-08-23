import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/environment.dart';
import 'package:showcase/src/storyboard_scope.dart';
import 'package:showcase/src/ui/environment_layout.dart';

class StoryboardViewer extends StatefulWidget {
  @override
  _StoryboardViewerState createState() => _StoryboardViewerState();
}

class _StoryboardViewerState extends State<StoryboardViewer> {
  Map<String, dynamic> _values = Map();

  Widget content() {
    Widget child =
        Environment().definition.builder(context, PropValues(_values));

    if (Environment().constraints.maxWidth > 0 ||
        Environment().constraints.maxHeight > 0) {
      child = Container(
        constraints: Environment().constraints,
        child: child,
      );
    }

    if (Environment().textScaleFactor != 1.0) {
      child = MediaQuery(
        child: child,
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: Environment().textScaleFactor,
          devicePixelRatio: 3.6,
        ),
      );
    }

    return child;
  }

  @override
  initState() {
    initValues();
    super.initState();
  }

  @override
  void didUpdateWidget(StoryboardViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    (context as Element).markNeedsBuild();
  }

  Widget storyboard() {
    return Environment().definition.storyboard ?? DefaultStoryboard();
  }

  @override
  Widget build(BuildContext context) {
    return StoryboardScope(
      content: content(),
      onPropChange: (id, value) {
        setState(() {
          _values[id] = value;
        });
      },
      child: EnvironmentLayout(
        onChanged: () {
          if ((context as Element).dirty == false) {
            Future.delayed(Duration.zero, () {
              setState(() {});
            });
          }
        },
        child: storyboard(),
      ),
    );
  }

  void initValues() {
    var props = Environment().definition.props;
    if (props != null && props.length > 0) {
      setState(() {
        props.forEach((e) {
          _values[e.id] = e.initialData;
        });
      });
    }
  }
}
