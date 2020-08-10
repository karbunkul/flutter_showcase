import 'package:flutter/material.dart';
import 'package:showcase/src/change_notifier_builder.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/device_item.dart';
import 'package:showcase/src/scene_view_page.dart';
import 'package:showcase/src/preferences.dart';
import 'package:showcase/src/theme_item.dart';

class ShowcaseListPage extends StatefulWidget {
  final Preferences preferences;
  final List<Definition> definitions;

  const ShowcaseListPage({Key key, this.definitions, this.preferences})
      : super(key: key);
  @override
  _ShowcaseListPageState createState() => _ShowcaseListPageState();
}

class _ShowcaseListPageState extends State<ShowcaseListPage> {
  List<Definition> get definitions {
    return widget.definitions != null ? widget.definitions : [];
  }

  List<Widget> actions() {
    List<Widget> items = [];

    if (widget.preferences.themes.length > 1) {
      items.add(PopupMenuButton<ThemeItem>(
        itemBuilder: (_) {
          return widget.preferences.themes.map((e) {
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
          widget.preferences.changeTheme(value.data);
        },
      ));
    }

    if (widget.preferences.devices.length > 1) {
      items.add(PopupMenuButton<DeviceItem>(
        itemBuilder: (_) {
          return widget.preferences.devices.map((e) {
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
          widget.preferences.changeDevice(
            width: value.width,
            height: value.height,
          );
        },
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.preferences.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Showcase'),
          actions: actions(),
        ),
        body: buildList(),
      ),
    );
  }

  Widget buildList() {
    if (definitions.length == 0) {
      return Center(child: Text('Add definitions'));
    }
    return ListView.builder(
      itemBuilder: (_, index) {
        var item = definitions.elementAt(index);
        return ListTile(
          title: Text(item.title),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ChangeNotifierBuilder(
                model: widget.preferences,
                builder: (_, pref) => SceneViewPage(
                  definition: item,
                  preferences: pref,
                ),
              ),
            ));
          },
        );
      },
      itemCount: definitions.length,
    );
  }
}
