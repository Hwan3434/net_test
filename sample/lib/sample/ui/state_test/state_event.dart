part of 'state_test_widget.dart';

mixin class StateTestEvent {
  void updateName(
    WidgetRef ref, {
    required String name,
  }) {
    ref.read(_stateTestProvider.notifier).update(
          name: name,
        );
  }

  void updateTest(
    WidgetRef ref, {
    required String test,
  }) {
    ref.read(_stateTestProvider.notifier).update(
          test: test,
        );
  }

  void countUp(
    WidgetRef ref,
  ) {
    ref.read(_stateTestProvider.notifier).up();
  }

  void countDown(
    WidgetRef ref,
  ) {
    ref.read(_stateTestProvider.notifier).down();
  }
}
