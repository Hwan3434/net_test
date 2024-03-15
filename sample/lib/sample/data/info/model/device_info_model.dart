enum OsType {
  ios,
  aos,
}

class DeviceInfoModel {
  final String deviceId;
  final bool isTablet;
  final OsType os;
  final int osVersion;

  const DeviceInfoModel({
    required this.deviceId,
    required this.isTablet,
    required this.os,
    required this.osVersion,
  });
}
