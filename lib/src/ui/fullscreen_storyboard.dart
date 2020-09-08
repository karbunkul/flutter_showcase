import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';
import 'package:showcase/showcase.dart';

class FullscreenStoryboard extends StatefulWidget {
  @override
  _FullscreenStoryboardState createState() => _FullscreenStoryboardState();
}

class _FullscreenStoryboardState extends State<FullscreenStoryboard>
    with TickerProviderStateMixin {
  TabController controller;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(
      child: TabBarView(
        controller: controller,
        children: <Widget>[
          content(),
          _Props(
            key: _key,
          ),
        ],
      ),
    );
  }

  StoryboardScope get scope => StoryboardScope.of(context);

  Widget content() {
    return Center(child: scope.content);
  }
}

class _Props extends StatefulWidget {
  const _Props({Key key}) : super(key: key);

  @override
  __PropsState createState() => __PropsState();
}

class __PropsState extends State<_Props> with AutomaticKeepAliveClientMixin {
  StoryboardScope get scope => StoryboardScope.of(context);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Properties'),
        )),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            var prop = scope.props.elementAt(index);
            return ListTile(
              title: Text(
                'property: ${prop.entity.id}',
                style: TextStyle(fontSize: 12),
              ),
              subtitle: DynamicProp(
                definition: prop.entity,
                initialData: prop.value,
                onPropChange: scope.onPropChanged,
              ),
            );
          },
          childCount: scope.definition.props.length ?? 0,
        ),
      ),
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
