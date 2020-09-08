import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/entities/entity_meta.dart';
import 'package:showcase/src/storyboard_scope.dart';
import 'package:showcase/src/ui/device_preview_area.dart';

class DefaultStoryboard extends StatefulWidget {
  @override
  _DefaultStoryboardState createState() => _DefaultStoryboardState();
}

class _DefaultStoryboardState extends State<DefaultStoryboard> {
  List<Widget> actions() {
    List<Widget> items = [];

    if (scope.textScaleFactors.length > 1) {
      items.add(PopupMenuButton<TextScaleFactorState>(
        itemBuilder: (_) {
          return scope.textScaleFactors.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<TextScaleFactorState>(
              child: ListTile(
                title: Text(e.entity.title),
                trailing: trailing,
              ),
              value: e,
            );
          }).toList();
        },
        icon: Icon(Icons.text_fields),
        onSelected: (value) {
          scope.changeTextScaleFactor(value.entity.scaleFactor);
        },
      ));
    }

    if (scope.themes.length > 1) {
      items.add(PopupMenuButton<ThemeState>(
        itemBuilder: (_) {
          return scope.themes.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<ThemeState>(
              child: ListTile(
                title: Text(e.entity.title),
                trailing: trailing,
              ),
              value: e,
            );
          }).toList();
        },
        icon: Icon(Icons.palette),
        onSelected: (value) {
          scope.changeTheme(value.entity.data);
        },
      ));
    }

    if (scope.devices.length > 1) {
      items.add(PopupMenuButton<DeviceState>(
        itemBuilder: (_) {
          return scope.devices.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<DeviceState>(
              child: ListTile(
                title: Text(e.entity.title),
                trailing: trailing,
              ),
              value: e,
            );
          }).toList();
        },
        icon: Icon(Icons.devices),
        onSelected: (value) {
          scope.changeDevice(
            width: value.entity.width,
            height: value.entity.height,
          );
        },
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scope.definition.title),
        actions: actions(),
      ),
      body: body(),
    );
  }

  Widget body() {
    return CustomScrollView(
      slivers: <Widget>[
        content(),
        SliverToBoxAdapter(child: SizedBox(height: 32)),
        presets(),
        props(),
      ],
    );
  }

  Widget content() {
    return SliverToBoxAdapter(
      child: DevicePreviewArea(
        child: scope.content,
      ),
    );
  }

  SliverList props() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          var prop = scope.props.elementAt(index);
          return ListTile(
            title: Text(
              'property: ${prop.entity.id}',
              style: TextStyle(fontSize: 12),
            ),
            subtitle: DynamicProp(
              initialData: prop.value,
              definition: prop.entity,
              onPropChange: scope.onPropChanged,
            ),
          );
        },
        childCount: scope.definition.props.length ?? 0,
      ),
    );
  }

  StoryboardScope get scope => StoryboardScope.of(context);

  Widget presets() {
    Widget child = Container();

    if (scope.presets.length > 0) {
      child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<PresetState>(
          hint: Text('Predefined state values'),
          underline: Container(),
          items: scope.presets.map((value) {
            return new DropdownMenuItem<PresetState>(
              value: value,
              child: Text(value.entity.title),
            );
          }).toList(),
          onChanged: (_) {
            scope.onPresetChanged(_.entity);
          },
        ),
      );
    }

    return SliverToBoxAdapter(child: child);
  }
}
