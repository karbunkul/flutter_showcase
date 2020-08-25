import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
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
      items.add(PopupMenuButton<EntityMeta<TextScaleFactorInfo>>(
        itemBuilder: (_) {
          return scope.textScaleFactors.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<EntityMeta<TextScaleFactorInfo>>(
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
      items.add(PopupMenuButton<EntityMeta<ThemeInfo>>(
        itemBuilder: (_) {
          return scope.themes.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<EntityMeta<ThemeInfo>>(
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
      items.add(PopupMenuButton<EntityMeta<DeviceInfo>>(
        itemBuilder: (_) {
          return scope.devices.map((e) {
            var trailing;
            if (e.current == true) {
              trailing = Icon(Icons.check);
            }
            return PopupMenuItem<EntityMeta<DeviceInfo>>(
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
          var prop = scope.definition.props.elementAt(index);
          return ListTile(
            title: Text(
              'property: ${prop.id}',
              style: TextStyle(fontSize: 12),
            ),
            subtitle: DynamicProp(
              definition: prop,
              onPropChange: scope.onPropChange,
            ),
          );
        },
        childCount: scope.definition.props.length ?? 0,
      ),
    );
  }

  StoryboardScope get scope => StoryboardScope.of(context);
}
