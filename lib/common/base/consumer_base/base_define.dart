import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef BaseWidgetBuilder<T> = Widget Function(T);

mixin BaseMapBuilderDefine<T> {
  void initializeWidgetMap(WidgetRef ref);

  final Map<Orientation, Map<String, BaseWidgetBuilder<T>>> _widgetMap = {
    Orientation.portrait: {},
    Orientation.landscape: {}
  };

  @protected
  void buildAll(
    String widgetMapKey, {
    required BaseWidgetBuilder<T> portraitFunc,
    BaseWidgetBuilder<T>? landscapeFunc,
  }) {
    _widgetMap[Orientation.portrait]![widgetMapKey] = portraitFunc;
    _widgetMap[Orientation.landscape]![widgetMapKey] =
        landscapeFunc ?? portraitFunc;
  }

  Widget runBuild(
    Orientation orientation,
    T state,
  ) {
    return _widgetMap[orientation]![state.runtimeType.toString()]!(
      state,
    );
  }
}
