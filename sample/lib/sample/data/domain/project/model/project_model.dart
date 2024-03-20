import 'package:sample/sample/data/domain/user/model/user_model.dart';

enum ProjectState {
  wait,
  loading,
  success,
  fail;
}

class ProjectProviderModel {
  final ProjectStateModel projectStateModel;

  const ProjectProviderModel({
    required this.projectStateModel,
  });

  factory ProjectProviderModel.init() => ProjectProviderModel(
        projectStateModel:
            ProjectStateModel(state: ProjectState.wait, items: []),
      );

  ProjectProviderModel copyWith({
    ProjectStateModel? projectStateModel,
  }) {
    return ProjectProviderModel(
      projectStateModel: projectStateModel ?? this.projectStateModel,
    );
  }
}

class ProjectStateModel {
  final ProjectState state;
  final List<ProjectModel> items;

  const ProjectStateModel({
    required this.state,
    required this.items,
  });

  ProjectStateModel copyWith({
    ProjectState? state,
    List<ProjectModel>? items,
  }) {
    return ProjectStateModel(
      state: state ?? this.state,
      items: items ?? this.items,
    );
  }
}

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
