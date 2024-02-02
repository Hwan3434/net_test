import 'package:flutter/material.dart';

typedef ClsBaseFunction<T> = Widget Function(T, Orientation);

mixin ClsMapBuilderDefine<T> {
  final Map<Orientation, Map<String, ClsBaseFunction<T>>> _widgetMap = {
    Orientation.portrait: {},
    Orientation.landscape: {},
  };

  @protected
  void initializeWidgetMap();

  @protected
  void buildAll(
    String widgetMapKey, {
    required ClsBaseFunction<T> portraitFunc,
    ClsBaseFunction<T>? landscapeFunc,
  }) {
    _widgetMap[Orientation.portrait]![widgetMapKey] = portraitFunc;
    _widgetMap[Orientation.landscape]![widgetMapKey] =
        landscapeFunc ?? portraitFunc;
  }

  @protected
  void setPortrait(T model, ClsBaseFunction<T> func) {
    _widgetMap[Orientation.portrait]![model.runtimeType.toString()] = func;
  }

  @protected
  void setLandscape(T model, ClsBaseFunction<T> func) {
    _widgetMap[Orientation.landscape]![model.runtimeType.toString()] = func;
  }

  /// 새로 추가된 것.
  Widget runBuild(T model, Orientation orientation) {
    return _widgetMap[orientation]![model.runtimeType.toString()]!(
      model,
      orientation,
    );
  }
}
