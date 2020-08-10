import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/device_item.dart';
import 'package:showcase/src/scene_context.dart';
import 'package:showcase/src/preferences.dart';
import 'package:showcase/src/theme_item.dart';

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

    if (widget.preferences.constraints.maxWidth > 0 ||
        widget.preferences.constraints.maxHeight > 0) {
      child = Container(
        constraints: widget.preferences.constraints,
        child: child,
      );
    }

    return SceneContext(
      definition: widget.definition,
      child: child,
      changeTheme: widget.preferences.changeTheme,
      changeDevice: widget.preferences.changeDevice,
      themes: widget.preferences.themes,
      devices: widget.preferences.devices,
      isEmulateDeviceConstraints: widget.preferences.isEmulateDeviceConstraints,
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

  Widget _body() {
    return Stack(
      children: [
        _child(),
        DraggableScrollableSheet(
          minChildSize: 0.12,
          initialChildSize: 0.12,
          maxChildSize: 0.75,
          builder: (_, controller) {
            return Card(
              child: _properties(controller),
              elevation: 12,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _child() {
    if (scene.isEmulateDeviceConstraints) {
      return Column(
        children: <Widget>[
          _currentDeviceInfo(),
          Align(
            child: scene.child,
            alignment: Alignment.topCenter,
          ),
        ],
      );
    }

    return scene.child;
  }

  _currentDeviceInfo() {
    var device = scene.devices.firstWhere((device) => device.current);
    return ListTile(
      title: Text('Preview area emulate device'),
      subtitle: Text(device.title),
      trailing: Text('${device.width.toInt()} x ${device.height.toInt()}'),
    );
  }

  Widget _properties(ScrollController controller) {
    var count = scene.definition.props?.length ?? 0;
    return CustomScrollView(
      controller: controller,
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Column(
              children: <Widget>[
                _draggingHandle(),
                SizedBox(height: 16),
                Text('Properties'),
                SizedBox(height: 24),
              ],
            )),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scene.definition.title),
        actions: actions(),
      ),
      body: _body(),
    );
  }

  List<Widget> actions() {
    List<Widget> items = [];

    if (scene.themes.length > 1) {
      items.add(PopupMenuButton<ThemeItem>(
        itemBuilder: (_) {
          return scene.themes.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<ThemeItem>(
              child: ListTile(
                title: Text(e.title),
                trailing: trailing,
              ),
              value: e,
            );
          }).toList();
        },
        icon: Icon(Icons.palette),
        onSelected: (value) {
          scene.changeTheme(value.data);
        },
      ));
    }

    if (scene.devices.length > 1) {
      items.add(PopupMenuButton<DeviceItem>(
        itemBuilder: (_) {
          return scene.devices.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<DeviceItem>(
              child: ListTile(
                title: Text(e.title),
                trailing: trailing,
              ),
              value: e,
            );
          }).toList();
        },
        icon: Icon(Icons.devices),
        onSelected: (value) {
          scene.changeDevice(
            width: value.width,
            height: value.height,
          );
        },
      ));
    }

    return items;
  }

  _draggingHandle() {
    return Container(
      height: 5,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
