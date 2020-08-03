import 'package:flutter/widgets.dart';

typedef ItemBuilder = Function(BuildContext context, ChangeNotifier model);

class ChangeNotifierBuilder extends StatefulWidget {
  final ChangeNotifier model;
  final ItemBuilder builder;
  final VoidCallback onChanged;

  const ChangeNotifierBuilder({
    Key key,
    @required this.model,
    @required this.builder,
    this.onChanged,
  }) : super(key: key);

  @override
  _ChangeNotifierBuilderState createState() => _ChangeNotifierBuilderState();
}

class _ChangeNotifierBuilderState extends State<ChangeNotifierBuilder> {
  @override
  void initState() {
    super.initState();

    widget.model.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.model.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.model);
  }

  void _listener() {
    (context as Element).markNeedsBuild();
    if (widget.onChanged != null) widget.onChanged();
  }
}
