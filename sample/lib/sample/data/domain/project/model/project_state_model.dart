import 'project_model.dart';

enum ProjectState {
  wait,
  loading,
  success,
  fail;
}

class ProjectStateModel {
  final ProjectState state;
  final List<ProjectModel> items;

  const ProjectStateModel({
    required this.state,
    required this.items,
  });

  factory ProjectStateModel.init() =>
      ProjectStateModel(state: ProjectState.wait, items: []);

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
