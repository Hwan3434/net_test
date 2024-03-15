enum AgentState {
  init,
  wait,
  loading,
  success,
  error,
}

class AgentModel {
  final AgentState state;
  final AgentDataModel? data;

  const AgentModel({
    required this.state,
    this.data,
  });

  AgentModel copyWith({
    AgentState? state,
    AgentDataModel? model,
  }) {
    return AgentModel(
      state: state ?? this.state,
      data: model,
    );
  }
}

class AgentDataModel {
  final String id;
  final String pw;
  final String name;
  final int age;
  final String refreshToken;
  final String accessToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  const AgentDataModel({
    required this.id,
    required this.pw,
    required this.name,
    required this.age,
    required this.refreshToken,
    required this.accessToken,
  });

  AgentDataModel copyWith({
    String? id,
    String? pw,
    String? name,
    int? age,
    String? refreshToken,
    String? accessToken,
  }) {
    return AgentDataModel(
      id: id ?? this.id,
      pw: pw ?? this.pw,
      name: name ?? this.name,
      age: age ?? this.age,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
