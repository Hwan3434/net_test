part of 'state_test_widget.dart';

final _stateTestProvider =
    StateNotifierProvider<_StateTestNotifier, StateTestViewModel>((ref) {
  final org = ref.read(GlobalStateStorage().loginOrganizationProvider);
  return _StateTestNotifier(
      StateTestViewModel(count: 0, name: org, test: 'test'));
});

class _StateTestNotifier extends StateNotifier<StateTestViewModel> {
  _StateTestNotifier(super.state);

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

  void update({
    int? count,
    String? name,
    String? test,
  }) {
    state = state.copyWith(
      name: name,
      count: count,
      test: test,
    );
  }
}

class StateTestViewModel {
  final int count;
  final String name;
  final String test;

  const StateTestViewModel({
    required this.count,
    required this.name,
    required this.test,
  });

  factory StateTestViewModel.create() => StateTestViewModel(
        count: 0,
        name: '',
        test: '',
      );

  StateTestViewModel copyWith({
    int? count,
    String? name,
    String? test,
  }) {
    return StateTestViewModel(
      count: count ?? this.count,
      name: name ?? this.name,
      test: test ?? this.test,
    );
  }
}
