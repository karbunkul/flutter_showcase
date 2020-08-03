import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/scene_context.dart';
import 'package:showcase/src/preferences.dart';

class SceneViewPage extends StatefulWidget {
  final Definition definition;
  final Preferences preferences;

  const SceneViewPage({Key key, @required this.definition, this.preferences})
      : super(key: key);
  @override
  _SceneViewPageState createState() => _SceneViewPageState();
}

class _SceneViewPageState extends State<SceneViewPage> {
  Map<String, dynamic> _values = Map();

  @override
  initState() {
    initValues();
    super.initState();
  }

  SceneContext get sceneContext {
    Widget child = widget.definition.builder(context, PropValues(_values));

    return SceneContext(
      definition: widget.definition,
      child: child,
      changeTheme: widget.preferences.changeTheme,
      themes: widget.preferences.themes,
      onPropChange: (id, value) {
        setState(() {
          _values[id] = value;
        });
      },
    );
  }

  Widget buildScene() {
    if (widget.definition.sceneBuilder != null) {
      return widget.definition.sceneBuilder(context, sceneContext);
    }
    return _DefaultScene(scene: sceneContext);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(child: buildScene(), data: widget.preferences.themeData);
  }

  void initValues() {
    var props = widget.definition.props;
    if (props != null && props.length > 0) {
      setState(() {
        props.forEach((e) {
          _values[e.id] = e.initialData;
        });
      });
    }
  }
}

class _DefaultScene extends StatelessWidget {
  final SceneContext scene;

  const _DefaultScene({Key key, @required this.scene}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var count = scene.definition.props?.length ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(scene.definition.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  scene.child,
                  SizedBox(height: 32),
                  Text('Custom properties'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                var prop = scene.definition.props.elementAt(index);
                return ListTile(
                  title: Text(
                    'property: ${prop.id}',
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: DynamicProp(
                    definition: prop,
                    onPropChange: scene.onPropChange,
                  ),
                );
              },
              childCount: count,
            ),
          ),
        ],
      ),
    );
  }
}
