class AgentModel {
  final String id;
  final String pw;
  final String name;
  final int age;
  final String refreshToken;
  final String accessToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  const AgentModel({
    required this.id,
    required this.pw,
    required this.name,
    required this.age,
    required this.refreshToken,
    required this.accessToken,
  });

  AgentModel copyWith({
    String? id,
    String? pw,
    String? name,
    int? age,
    String? refreshToken,
    String? accessToken,
  }) {
    return AgentModel(
      id: id ?? this.id,
      pw: pw ?? this.pw,
      name: name ?? this.name,
      age: age ?? this.age,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
