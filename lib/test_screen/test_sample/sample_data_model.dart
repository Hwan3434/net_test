import 'package:domain/sample/login/provider/login_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sample_data_model.g.dart';

@riverpod
class SampleViewModel extends _$SampleViewModel {
  @override
  SampleDataModel build() {
    return SampleDataModel(
      title: 'title',
      description: 'description',
    );
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 3));
    state = state.copyWith(
      title: 'title async',
      description: 'description async',
    );
  }

  void update({
    required String? title,
    required String? description,
  }) {
    state = state.copyWith(title: title, description: description);
  }

  void updateUsecase() async {
    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      state = state.copyWith(
        title: value.first.name,
        description: value.first.id.toString(),
      );
    }).catchError((e) {
      state = state.copyWith(title: 'err', description: 'err');
    });
  }
}

class SampleDataModel {
  final String? title;
  final String? description;

  SampleDataModel({
    required this.title,
    required this.description,
  });

  SampleDataModel copyWith({
    String? title,
    String? description,
  }) {
    return SampleDataModel(
      title: title,
      description: description,
    );
  }
}
