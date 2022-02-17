import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DependenciesInitializer<T extends Object> extends StatefulWidget {
  final Widget Function(BuildContext, T) splashBuilder;

  final Widget Function(BuildContext, Object) errorBuilder;

  final Stream<T> Function(BuildContext) initializer;

  final Widget child;

  const DependenciesInitializer({
    Key? key,
    required this.splashBuilder,
    required this.errorBuilder,
    required this.initializer,
    required this.child,
  }) : super(key: key);

  @override
  _DependenciesInitializerState<T> createState() =>
      _DependenciesInitializerState<T>();
}

class _DependenciesInitializerState<T extends Object>
    extends State<DependenciesInitializer<T>> {
  Stream<T>? _stream;

  @override
  void initState() {
    _stream = widget.initializer(context);
    super.initState();
  }

  @override
  void didUpdateWidget(DependenciesInitializer<T> oldWidget) {
    if (widget.initializer != oldWidget.initializer) {
      _stream = widget.initializer(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return widget.child;
          } else {
            return widget.splashBuilder.call(context, snapshot.data!);
          }
        } else if (snapshot.hasError) {
          debugPrint('❌ DependenciesInitializerException: ${snapshot.error}');

          return widget.errorBuilder.call(context, snapshot.error ?? '');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
