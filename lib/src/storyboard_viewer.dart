import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/entities/preset_info.dart';
import 'package:showcase/src/environment.dart';
import 'package:showcase/src/storyboard_scope.dart';
import 'package:showcase/src/ui/environment_layout.dart';

class StoryboardViewer extends StatefulWidget {
  @override
  _StoryboardViewerState createState() => _StoryboardViewerState();
}

class _StoryboardViewerState extends State<StoryboardViewer> {
  Map<String, dynamic> _values = Map();
  String _preset;

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
      state: _values,
      content: content(),
      onPropChanged: (id, value) {
        setState(() {
          _values[id] = value;
        });
      },
      presets: presets(),
      onResetState: _onResetState,
      onPresetChanged: _onPresetChanged,
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

  void resetState() {
    var props = Environment().definition.props;
    if (props != null && props.length > 0) {
      setState(() {
        props.forEach((e) {
          _values[e.id] = e.initialData;
        });
      });
    }
  }

  void initValues() {
    var values = Environment().getValues(Environment().definition.title);
    if (values != null) {
      _values = values;
    } else {
      resetState();
    }
  }

  void _onPresetChanged(PresetInfo value) {
    setState(() {
      _preset = value.title;
      Map<String, dynamic> values = Map();
      final List<Prop> props = Environment().definition.props;
      if (props != null && props.length > 0) {
        props.forEach((e) {
          values[e.id] = value.values[e.id] ?? e.initialData;
        });
      }
      _values = values;
      Environment().setValues(
        id: Environment().definition.title,
        values: values,
      );
    });
  }

  void _onResetState() {
    setState(() {
      _preset = null;
      resetState();
    });
  }

  List<PresetState> presets() {
    final presets = Environment().definition.presets;
    if (presets != null) {
      return presets.map((e) {
        return PresetState(entity: e, current: e.title == _preset);
      }).toList();
    }
    return [];
  }
}
