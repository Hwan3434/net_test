import 'package:sample/sample/data/domain/user/model/user_state_model.dart';

class ProjectModel {
  final int id;
  final String name;
  final UserStateModel userStateModel;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.userStateModel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  ProjectModel copyWith({
    int? id,
    String? name,
    UserStateModel? userStateModel,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userStateModel: userStateModel ?? this.userStateModel,
    );
  }
}
