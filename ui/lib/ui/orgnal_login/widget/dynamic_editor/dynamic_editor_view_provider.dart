import 'package:flutter_riverpod/flutter_riverpod.dart';

final dynamicEditorViewProvider = StateNotifierProvider.autoDispose<
    _DynamicEditorNotifier, DynamicEditorViewModel>((ref) {
  final List<DynamicEditorDataModel> responseServerData = [
    DynamicEditorDataModel(id: 1, name: 'type1', editorString: 'history 1'),
    DynamicEditorDataModel(id: 2, name: 'type2', editorString: 'history 2'),
    DynamicEditorDataModel(id: 3, name: 'type3', editorString: 'history 3'),
    DynamicEditorDataModel(id: 4, name: 'type4', editorString: 'history 4'),
    DynamicEditorDataModel(id: 5, name: 'type5', editorString: 'history 5'),
    DynamicEditorDataModel(id: 6, name: 'type6', editorString: 'history 6'),
    DynamicEditorDataModel(id: 7, name: 'type7', editorString: 'history 7'),
    DynamicEditorDataModel(id: 8, name: 'type8', editorString: 'history 8'),
    DynamicEditorDataModel(id: 9, name: 'type9', editorString: 'history 9'),
    DynamicEditorDataModel(id: 10, name: 'type10', editorString: 'history 10'),
    DynamicEditorDataModel(id: 11, name: 'type11', editorString: 'history 11'),
    DynamicEditorDataModel(id: 12, name: 'type12', editorString: 'history 12'),
  ];
  return _DynamicEditorNotifier(
      DynamicEditorViewModel(data: responseServerData));
});

class _DynamicEditorNotifier extends StateNotifier<DynamicEditorViewModel> {
  _DynamicEditorNotifier(super.state);

  void clear() {
    state = state.copyWith(
      data: state.data.map((e) {
        return DynamicEditorDataModel(
          id: e.id,
          name: e.name,
          editorString: '',
        );
      }).toList(),
    );
  }

  void update(int id, String value) {
    state = state.copyWith(
      data: state.data.map((e) {
        if (e.id == id) {
          return DynamicEditorDataModel(
            id: e.id,
            name: e.name,
            editorString: value,
          );
        } else {
          return e;
        }
      }).toList(),
    );
  }
}

class DynamicEditorViewModel {
  final List<DynamicEditorDataModel> data;

  const DynamicEditorViewModel({
    required this.data,
  });

  DynamicEditorViewModel copyWith({
    List<DynamicEditorDataModel>? data,
  }) {
    return DynamicEditorViewModel(
      data: data ?? this.data,
    );
  }
}

class DynamicEditorDataModel {
  final int id;
  final String name;
  final String editorString;

  const DynamicEditorDataModel({
    required this.id,
    required this.name,
    required this.editorString,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicEditorDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
