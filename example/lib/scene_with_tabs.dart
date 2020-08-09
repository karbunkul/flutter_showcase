import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

class SceneWithTabs extends StatefulWidget {
  final SceneContext scene;

  const SceneWithTabs({Key key, @required this.scene}) : super(key: key);

  @override
  _SceneWithTabsState createState() => _SceneWithTabsState();
}

class _SceneWithTabsState extends State<SceneWithTabs> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scene.definition.title),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.palette),
        onPressed: () {
          widget.scene.changeTheme(widget.scene.themes[0].data);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            title: Text('Canvas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Properties'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Info'),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IndexedStack(
        children: [
          Center(child: widget.scene.child),
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    var prop = widget.scene.definition.props.elementAt(index);
                    return ListTile(
                      title: Text(
                        'property: ${prop.id}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: DynamicProp(
                        definition: prop,
                        onPropChange: widget.scene.onPropChange,
                      ),
                    );
                  },
                  childCount: widget.scene.definition.props?.length ?? 0,
                ),
              ),
            ],
          ),
          Container(),
        ],
        index: _tabIndex,
      ),
    );
  }
}
