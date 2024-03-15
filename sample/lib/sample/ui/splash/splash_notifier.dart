import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash_model.dart';

class SplashNotifier extends StateNotifier<SplashModel> {
  SplashNotifier(super.state);

  void splashInitTrue() {
    state = state.copyWith(splashLoading: true);
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
