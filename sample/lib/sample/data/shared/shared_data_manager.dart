import 'package:shared_preferences/shared_preferences.dart';

class SharedDataManger {
  SharedDataManger._privateConstructor();

  static final SharedDataManger _instance =
      SharedDataManger._privateConstructor();

  factory SharedDataManger() {
    return _instance;
  }
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void clear() {
    _prefs.remove(_isLockUse);
    _prefs.remove(_lockPassword);
    _prefs.remove(_currentTab);
  }

  final String _isLockUse = 'isLockUse';
  void setIsLockUse(bool isLockUse) async =>
      _prefs.setBool(_isLockUse, isLockUse);

  bool getIsLockUse() => _prefs.getBool(_isLockUse) ?? false;

  final String _lockPassword = 'lockPassword';
  void setLockPassword(String password) async {
    _prefs.setString(_lockPassword, password);
    if (password.isEmpty) {
      setIsLockUse(false);
    }
  }

  String getLockPassword() => _prefs.getString(_lockPassword) ?? '';

  final String _currentTab = 'currentTab';
  void setCurrentTab(int password) async {
    _prefs.setInt(_currentTab, password);
  }

  int getCurrentTab() => _prefs.getInt(_currentTab) ?? 0;
}
