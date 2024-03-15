import 'package:flutter/widgets.dart';
import 'package:sample/sample/data/flavor/enviroment.dart';
import 'package:sample/sample/data/info/model/app_info_model.dart';
import 'package:sample/sample/data/info/model/device_info_model.dart';

class AppInfoManger {
  AppInfoManger._privateConstructor();
  static final AppInfoManger _instance = AppInfoManger._privateConstructor();
  factory AppInfoManger() => _instance;

  late final Environment _env;
  late final AppInfoModel _app;
  late final DeviceInfoModel _device;

  Future<void> init() async {
    _env = Environment.alpha();
  }

  Environment getEnvironment() {
    return _env;
  }

  String get appName => _app.appName;
  String get deviceName => _device.deviceId;
}
