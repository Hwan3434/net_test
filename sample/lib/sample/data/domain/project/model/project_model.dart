enum ProjectState {
  wait,
  loading,
  success,
  fail;
}

class ProjectModel {
  final ProjectState state;
  final List<ProjectDataModel> items;

  const ProjectModel({
    required this.state,
    required this.items,
  });

  ProjectModel copyWith({
    ProjectState? state,
    List<ProjectDataModel>? items,
  }) {
    return ProjectModel(
      state: state ?? this.state,
      items: items ?? this.items,
    );
  }
}

class ProjectDataModel {
  final int id;
  final String name;

  const ProjectDataModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
