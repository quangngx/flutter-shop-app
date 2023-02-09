import 'package:flutter/material.dart';

//Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;

  final T? bloc;
  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  State<BlocProvider<T>> createState() => _BlocProviderState<T>();

  static T? of<T extends BlocBase>(BuildContext context) {
    final _BlocProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;
    return provider?.bloc;
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  final T bloc;

  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: widget.bloc!,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }
}
