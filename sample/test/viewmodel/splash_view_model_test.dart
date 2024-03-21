import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/sample/ui/splash/splash_model.dart';
import 'package:sample/sample/ui/splash/splash_notifier.dart';

import 'test_util.dart';

final splashTestProvider =
    StateNotifierProvider.autoDispose<SplashNotifier, SplashModel>((ref) {
  return SplashNotifier(
    SplashModel(
      count: 0,
      splashLoading: false,
    ),
  );
});

void main() {
  group('스플래시 뷰 모델 테스트', () {
    test('스플래시 뷰 모델 초기화 상태 파악', () {
      final lis = Listener<SplashModel>();
      final container = createContainer(splashTestProvider, lis);

      expect(container.read(splashTestProvider).count, 0);
      expect(container.read(splashTestProvider).splashLoading, false);
    });

    test('스플래시 뷰 모델 컨트롤', () {
      final lis = Listener<SplashModel>();
      final container = createContainer(splashTestProvider, lis);

      expect(container.read(splashTestProvider).count, 0);
      container.read(splashTestProvider.notifier).up();
      expect(container.read(splashTestProvider).count, 1);
      container.read(splashTestProvider.notifier).down();
      expect(container.read(splashTestProvider).count, 0);

      expect(container.read(splashTestProvider).splashLoading, false);
      container.read(splashTestProvider.notifier).splashInitTrue();
      expect(container.read(splashTestProvider).splashLoading, true);
    });
  });
}
