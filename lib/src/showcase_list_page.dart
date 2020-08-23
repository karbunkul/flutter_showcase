import 'package:flutter/material.dart';
import 'package:showcase/src/entities/definition.dart';
import 'package:showcase/src/entities/entities.dart';
import 'package:showcase/src/environment.dart';
import 'package:showcase/src/storyboard_viewer.dart';
import 'package:showcase/src/ui/environment_layout.dart';

class ShowcaseListPage extends StatefulWidget {
  final List<Definition> definitions;

  const ShowcaseListPage({Key key, this.definitions}) : super(key: key);
  @override
  _ShowcaseListPageState createState() => _ShowcaseListPageState();
}

class _ShowcaseListPageState extends State<ShowcaseListPage> {
  int _lastIndex;

  List<Definition> get definitions {
    return widget.definitions != null ? widget.definitions : [];
  }

  @override
  void didUpdateWidget(ShowcaseListPage oldWidget) {
    if (_lastIndex != null && definitions.length < _lastIndex)
      _lastIndex = null;

    if (_lastIndex != null)
      Environment().changeDefinition(definitions.elementAt(_lastIndex));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return EnvironmentLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Showcase'),
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
            _lastIndex = index;
            Environment().changeDefinition(item);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => StoryboardViewer(),
            ));
          },
        );
      },
      itemCount: definitions.length,
    );
  }
}
