import 'package:flutter/material.dart';
import 'package:showcase/src/change_notifier_builder.dart';
import 'package:showcase/src/definition.dart';
import 'package:showcase/src/scene_view_page.dart';
import 'package:showcase/src/preferences.dart';
import 'package:showcase/src/theme_info.dart';

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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.preferences.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Showcase'),
          actions: [
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: () {
                print(widget.preferences.themes[0].current);
                widget.preferences
                    .changeTheme(ThemeInfo(data: ThemeData.dark()));
              },
            )
          ],
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
