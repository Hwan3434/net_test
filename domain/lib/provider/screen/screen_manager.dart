import 'package:domain/provider/screen/model/login_screen_model.dart';
import 'package:domain/provider/screen/model/main_screen_model.dart';
import 'package:domain/provider/screen/screen_keys.dart';
import 'package:domain/provider/screen/state/login_screen_provider.dart';
import 'package:domain/provider/screen/state/main_screen_provider.dart';
import 'package:riverpod/riverpod.dart';

class ScreenManager {
  final String serviceId;
  final Map<ScreenKeys, AutoDisposeStateNotifierProvider> providers;

  ScreenManager({
    required this.serviceId,
    required this.providers,
  });

  ProviderBase getProvider(ScreenKeys key) {
    if (providers.containsKey(key)) {
      return providers[key]!;
    }
    _createProvider(key);
    return providers[key]!;
  }

  /// autoDispose는 어떻게 관리할껀데
  void _createProvider(ScreenKeys key) {
    switch(key){
      case ScreenKeys.main :
        providers[key] = StateNotifierProvider.autoDispose<MainScreenProvider, MainScreenModel>((ref) {
          return MainScreenProvider.create();
        });
      case ScreenKeys.login:
        providers[key] = StateNotifierProvider<LoginScreenProvider, LoginScreenModel>((ref) {
          return LoginScreenProvider.create();
        });
    }
  }
}