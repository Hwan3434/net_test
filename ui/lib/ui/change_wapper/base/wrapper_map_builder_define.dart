import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/log.dart';

typedef WrapperBaseFunction<VM> = Widget Function(VM, Orientation);

mixin WrapperMapBuilderDefine<VM> {
  final Map<Orientation, Map<String, WrapperBaseFunction<VM>>> _widgetMap = {
    Orientation.portrait: {},
    Orientation.landscape: {},
  };

  void initializeWidgetMap(WidgetRef ref);

  @protected
  void buildAll(
    String widgetMapKey, {
    required WrapperBaseFunction<VM> portraitFunc,
    WrapperBaseFunction<VM>? landscapeFunc,
  }) {
    _widgetMap[Orientation.portrait]![widgetMapKey] = portraitFunc;
    _widgetMap[Orientation.landscape]![widgetMapKey] =
        landscapeFunc ?? portraitFunc;
  }

  @protected
  void setPortrait(VM model, WrapperBaseFunction<VM> func) {
    _widgetMap[Orientation.portrait]![model.runtimeType.toString()] = func;
  }

  @protected
  void setLandscape(VM model, WrapperBaseFunction<VM> func) {
    _widgetMap[Orientation.landscape]![model.runtimeType.toString()] = func;
  }

  Widget runBuild(VM model, Orientation orientation) {
    Log.d('type : ${model.runtimeType}');
    return _widgetMap[orientation]![model.runtimeType.toString()]!(
      model,
      orientation,
    );
  }
}
