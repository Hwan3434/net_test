import 'package:flutter_riverpod/flutter_riverpod.dart';

final editorViewProvider =
    StateNotifierProvider<_EditorNotifier, EditorViewModel>((ref) {
  return _EditorNotifier(
    EditorViewModel.init(),
  );
});

class _EditorNotifier extends StateNotifier<EditorViewModel> {
  _EditorNotifier(super.state);

  void clear() {
    state = EditorViewModel.init();
  }

  void update({
    String? header,
    String? mid,
    String? bottom,
  }) {
    state = state.copyWith(
      header: header ?? state.header,
      mid: mid ?? state.mid,
      bottom: bottom ?? state.bottom,
    );
  }
}

class EditorViewModel {
  final String header;
  final String mid;
  final String bottom;

  const EditorViewModel({
    required this.header,
    required this.mid,
    required this.bottom,
  });

  factory EditorViewModel.init() => const EditorViewModel(
        header: '',
        mid: '',
        bottom: 'init 초기값',
      );

  EditorViewModel copyWith({
    String? header,
    String? mid,
    String? bottom,
  }) {
    return EditorViewModel(
      header: header ?? this.header,
      mid: mid ?? this.mid,
      bottom: bottom ?? this.bottom,
    );
  }
}
