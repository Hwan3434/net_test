import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';

import 'splash_model.dart';

class SplashNotifier extends StateNotifier<SplashModel> {
  SplashNotifier(super.state);

  void splashInitTrue() {
    state = state.copyWith(splashLoading: true);
  }

  void downloadInit(WidgetRef ref) {
    ref.read(GlobalStateStorage().agentStateProvider.notifier).downloadInit();
  }

  void up() {
    state = state.copyWith(
      count: state.count + 1,
    );
  }

  void down() {
    state = state.copyWith(
      count: state.count - 1,
    );
  }
}
