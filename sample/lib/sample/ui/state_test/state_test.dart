part of 'state_test_widget.dart';

mixin class StateTestState {
  int readCount(WidgetRef ref) =>
      ref.read(_stateTestProvider.select((value) => value.count));
  int watchCount(WidgetRef ref) =>
      ref.watch(_stateTestProvider.select((value) => value.count));

  String readName(WidgetRef ref) =>
      ref.read(_stateTestProvider.select((value) => value.name));
  String watchName(WidgetRef ref) =>
      ref.watch(_stateTestProvider.select((value) => value.name));
}
